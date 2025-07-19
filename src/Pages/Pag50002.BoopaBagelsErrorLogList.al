/// <summary>
/// Error Log List Page for comprehensive error monitoring and management
/// </summary>
page 50002 "BoopaBagels Error Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BoopaBagels Error Log";
    Caption = 'Boopa Bagels Error Log';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(ErrorEntries)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique entry number for the error log';
                }
                
                field("Timestamp"; Rec."Timestamp")
                {
                    ApplicationArea = All;
                    ToolTip = 'When the error occurred';
                }
                
                field("Error Category"; Rec."Error Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Category of the error';
                    Style = Attention;
                    StyleExpr = Rec."Error Category" in [Rec."Error Category"::Security, Rec."Error Category"::ApiError];
                }
                
                field("Operation"; Rec."Operation")
                {
                    ApplicationArea = All;
                    ToolTip = 'Operation that caused the error';
                }
                
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Error message details';
                    Width = 50;
                }
                
                field("Severity Level"; Rec."Severity Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Severity level of the error';
                    Style = Unfavorable;
                    StyleExpr = Rec."Severity Level" = Rec."Severity Level"::Critical;
                }
                
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'User who encountered the error';
                }
                
                field("Resolution Status"; Rec."Resolution Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Current resolution status';
                    Style = Favorable;
                    StyleExpr = Rec."Resolution Status" in [Rec."Resolution Status"::Resolved, Rec."Resolution Status"::"Auto-Resolved"];
                }
                
                field("Pattern ID"; Rec."Pattern ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Pattern identifier for similar errors';
                    Visible = false;
                }
                
                field("Correlation ID"; Rec."Correlation ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Correlation identifier for tracking';
                    Visible = false;
                }
            }
        }
        
        area(FactBoxes)
        {
            part(ErrorDetails; "BoopaBagels Error Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Entry No." = field("Entry No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewDetails)
            {
                ApplicationArea = All;
                Caption = 'View Details';
                Image = View;
                ToolTip = 'View detailed error information';
                
                trigger OnAction()
                begin
                    ShowErrorDetails();
                end;
            }
            
            action(MarkResolved)
            {
                ApplicationArea = All;
                Caption = 'Mark as Resolved';
                Image = Completed;
                ToolTip = 'Mark the selected error as resolved';
                Enabled = Rec."Resolution Status" <> Rec."Resolution Status"::Resolved;
                
                trigger OnAction()
                begin
                    MarkErrorAsResolved();
                end;
            }
            
            action(AnalyzePattern)
            {
                ApplicationArea = All;
                Caption = 'Analyze Pattern';
                Image = AnalysisView;
                ToolTip = 'Analyze patterns for the selected error';
                
                trigger OnAction()
                begin
                    AnalyzeErrorPattern();
                end;
            }
        }
        
        area(Navigation)
        {
            action(FilterBySimilar)
            {
                ApplicationArea = All;
                Caption = 'Filter Similar Errors';
                Image = Filter;
                ToolTip = 'Filter to show similar errors';
                
                trigger OnAction()
                begin
                    FilterSimilarErrors();
                end;
            }
            
            action(FilterByPattern)
            {
                ApplicationArea = All;
                Caption = 'Filter by Pattern';
                Image = FilterLines;
                ToolTip = 'Filter errors by pattern ID';
                Enabled = not IsNullGuid(Rec."Pattern ID");
                
                trigger OnAction()
                begin
                    FilterByPattern();
                end;
            }
        }
        
        area(Reporting)
        {
            action(ExportErrorData)
            {
                ApplicationArea = All;
                Caption = 'Export Error Data';
                Image = Export;
                ToolTip = 'Export error data for external analysis';
                
                trigger OnAction()
                begin
                    ExportErrorData();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // Update FactBox when record changes
        CurrPage.ErrorDetails.Page.UpdateErrorDetails(Rec);
    end;

    local procedure ShowErrorDetails()
    var
        ErrorDetailsPage: Page "BoopaBagels Error Details";
    begin
        ErrorDetailsPage.SetErrorRecord(Rec);
        ErrorDetailsPage.RunModal();
    end;

    local procedure MarkErrorAsResolved()
    var
        ResolutionNotes: Text[2048];
    begin
        if not Confirm('Mark this error as resolved?') then
            exit;
            
        ResolutionNotes := 'Manually marked as resolved by ' + UserId();
        
        Rec."Resolution Status" := Rec."Resolution Status"::Resolved;
        Rec."Resolution Notes" := ResolutionNotes;
        Rec."Resolution Timestamp" := CurrentDateTime();
        Rec."Resolved By" := UserId();
        Rec.Modify(true);
        
        Message('Error marked as resolved.');
        CurrPage.Update(false);
    end;

    local procedure AnalyzeErrorPattern()
    var
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
    begin
        Codeunit.Run(Codeunit::"BoopaBagels Error Intelligence", Rec);
        CurrPage.Update(false);
        Message('Pattern analysis completed for error %1', Rec."Entry No.");
    end;

    local procedure FilterSimilarErrors()
    begin
        Rec.SetRange("Error Category", Rec."Error Category");
        Rec.SetRange("Operation", Rec.Operation);
        CurrPage.Update(false);
        Message('Filtered to show similar errors: Category %1, Operation %2', Rec."Error Category", Rec.Operation);
    end;

    local procedure FilterByPattern()
    begin
        if not IsNullGuid(Rec."Pattern ID") then begin
            Rec.SetRange("Pattern ID", Rec."Pattern ID");
            CurrPage.Update(false);
            Message('Filtered to show errors with Pattern ID: %1', Rec."Pattern ID");
        end;
    end;

    local procedure ExportErrorData()
    var
        ErrorLogExport: Record "BoopaBagels Error Log";
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        JsonText: Text;
        FileName: Text;
    begin
        ErrorLogExport.CopyFilters(Rec);
        
        if not ErrorLogExport.FindSet() then begin
            Message('No error records to export.');
            exit;
        end;
        
        JsonText := ConvertErrorsToJson(ErrorLogExport);
        
        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(JsonText);
        TempBlob.CreateInStream(InStream);
        
        FileName := StrSubstNo('BC_Error_Export_%1.json', Format(CurrentDateTime(), 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2><Seconds,2>'));
        DownloadFromStream(InStream, 'Export Error Data', '', 'JSON Files (*.json)|*.json', FileName);
    end;

    local procedure ConvertErrorsToJson(var ErrorLogRec: Record "BoopaBagels Error Log"): Text
    var
        JsonArray: JsonArray;
        JsonObject: JsonObject;
        ResultText: Text;
    begin
        repeat
            Clear(JsonObject);
            JsonObject.Add('entryNo', ErrorLogRec."Entry No.");
            JsonObject.Add('errorId', ErrorLogRec."Error ID");
            JsonObject.Add('timestamp', ErrorLogRec."Timestamp");
            JsonObject.Add('category', Format(ErrorLogRec."Error Category"));
            JsonObject.Add('operation', ErrorLogRec.Operation);
            JsonObject.Add('errorMessage', ErrorLogRec."Error Message");
            JsonObject.Add('severityLevel', Format(ErrorLogRec."Severity Level"));
            JsonObject.Add('userId', ErrorLogRec."User ID");
            JsonObject.Add('resolutionStatus', Format(ErrorLogRec."Resolution Status"));
            JsonObject.Add('correlationId', ErrorLogRec."Correlation ID");
            if not IsNullGuid(ErrorLogRec."Pattern ID") then
                JsonObject.Add('patternId', ErrorLogRec."Pattern ID");
            
            JsonArray.Add(JsonObject);
        until ErrorLogRec.Next() = 0;
        
        JsonArray.WriteTo(ResultText);
        exit(ResultText);
    end;
}
