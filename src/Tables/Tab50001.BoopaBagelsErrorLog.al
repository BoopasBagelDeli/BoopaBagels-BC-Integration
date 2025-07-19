/// <summary>
/// Error Intelligence Table for comprehensive error tracking and pattern analysis
/// Following Azure best practices for error logging and diagnostics
/// </summary>
table 50001 "BoopaBagels Error Log"
{
    DataClassification = CustomerContent;
    Caption = 'Boopa Bagels Error Log';
    LookupPageId = "BoopaBagels Error Log List";
    DrillDownPageId = "BoopaBagels Error Log List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
            DataClassification = SystemMetadata;
        }

        field(2; "Error ID"; Guid)
        {
            Caption = 'Error ID';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }

        field(3; "Timestamp"; DateTime)
        {
            Caption = 'Timestamp';
            DataClassification = SystemMetadata;
            NotBlank = true;
        }

        field(4; "Error Category"; Enum "BoopaBagels Error Category")
        {
            Caption = 'Error Category';
            DataClassification = CustomerContent;
        }

        field(5; "Operation"; Text[100])
        {
            Caption = 'Operation';
            DataClassification = CustomerContent;
        }

        field(6; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
            DataClassification = CustomerContent;
        }

        field(7; "Stack Trace"; Blob)
        {
            Caption = 'Stack Trace';
            DataClassification = CustomerContent;
        }

        field(8; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }

        field(9; "Session ID"; Integer)
        {
            Caption = 'Session ID';
            DataClassification = SystemMetadata;
        }

        field(10; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = OrganizationIdentifiableInformation;
        }

        field(11; "Severity Level"; Option)
        {
            Caption = 'Severity Level';
            DataClassification = CustomerContent;
            OptionMembers = Information,Warning,Error,Critical;
            OptionCaption = 'Information,Warning,Error,Critical';
        }

        field(12; "Context Data"; Blob)
        {
            Caption = 'Context Data';
            DataClassification = CustomerContent;
        }

        field(13; "Correlation ID"; Guid)
        {
            Caption = 'Correlation ID';
            DataClassification = SystemMetadata;
        }

        field(14; "Source System"; Text[50])
        {
            Caption = 'Source System';
            DataClassification = SystemMetadata;
        }

        field(15; "Resolution Status"; Option)
        {
            Caption = 'Resolution Status';
            DataClassification = CustomerContent;
            OptionMembers = "Not Resolved","In Progress",Resolved,"Auto-Resolved";
            OptionCaption = 'Not Resolved,In Progress,Resolved,Auto-Resolved';
        }

        field(16; "Resolution Notes"; Text[2048])
        {
            Caption = 'Resolution Notes';
            DataClassification = CustomerContent;
        }

        field(17; "Resolved By"; Code[50])
        {
            Caption = 'Resolved By';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }

        field(18; "Resolution Timestamp"; DateTime)
        {
            Caption = 'Resolution Timestamp';
            DataClassification = SystemMetadata;
        }

        field(19; "Pattern ID"; Guid)
        {
            Caption = 'Pattern ID';
            DataClassification = SystemMetadata;
        }

        field(20; "Retry Count"; Integer)
        {
            Caption = 'Retry Count';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ErrorID; "Error ID") { }
        key(Timestamp; "Timestamp") { }
        key(Category; "Error Category", "Timestamp") { }
        key(Operation; "Operation", "Timestamp") { }
        key(CorrelationID; "Correlation ID") { }
        key(PatternID; "Pattern ID") { }
    }

    trigger OnInsert()
    begin
        if IsNullGuid("Error ID") then
            "Error ID" := CreateGuid();
        
        if "Timestamp" = 0DT then
            "Timestamp" := CurrentDateTime();
        
        if "User ID" = '' then
            "User ID" := UserId();
        
        if "Session ID" = 0 then
            "Session ID" := SessionId();
        
        if "Company Name" = '' then
            "Company Name" := CompanyName();
        
        if IsNullGuid("Correlation ID") then
            "Correlation ID" := CreateGuid();
    end;

    trigger OnModify()
    begin
        if ("Resolution Status" = "Resolution Status"::Resolved) and ("Resolution Timestamp" = 0DT) then begin
            "Resolution Timestamp" := CurrentDateTime();
            if "Resolved By" = '' then
                "Resolved By" := UserId();
        end;
    end;

    /// <summary>
    /// Creates a new error log entry with comprehensive context
    /// </summary>
    /// <param name="ErrorCategory">The category of the error</param>
    /// <param name="Operation">The operation that caused the error</param>
    /// <param name="ErrorMessage">The error message</param>
    /// <param name="SeverityLevel">The severity level of the error</param>
    /// <param name="ContextData">Additional context data</param>
    /// <returns>The Error ID of the created entry</returns>
    procedure CreateErrorEntry(ErrorCategory: Enum "BoopaBagels Error Category"; Operation: Text[100]; ErrorMessage: Text[2048]; SeverityLevel: Option; ContextData: Text): Guid
    var
        ErrorLogEntry: Record "BoopaBagels Error Log";
        ContextOutStream: OutStream;
    begin
        ErrorLogEntry.Init();
        ErrorLogEntry."Error Category" := ErrorCategory;
        ErrorLogEntry.Operation := Operation;
        ErrorLogEntry."Error Message" := ErrorMessage;
        ErrorLogEntry."Severity Level" := SeverityLevel;
        
        if ContextData <> '' then begin
            ErrorLogEntry."Context Data".CreateOutStream(ContextOutStream);
            ContextOutStream.WriteText(ContextData);
        end;
        
        ErrorLogEntry.Insert(true);
        exit(ErrorLogEntry."Error ID");
    end;

    /// <summary>
    /// Updates the resolution status of an error
    /// </summary>
    /// <param name="ErrorID">The Error ID to update</param>
    /// <param name="NewStatus">The new resolution status</param>
    /// <param name="ResolutionNotes">Notes about the resolution</param>
    procedure UpdateResolutionStatus(ErrorID: Guid; NewStatus: Option; ResolutionNotes: Text[2048])
    var
        ErrorLogEntry: Record "BoopaBagels Error Log";
    begin
        if ErrorLogEntry.Get(ErrorID) then begin
            ErrorLogEntry."Resolution Status" := NewStatus;
            ErrorLogEntry."Resolution Notes" := ResolutionNotes;
            ErrorLogEntry.Modify(true);
        end;
    end;
}
