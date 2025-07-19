pageextension 50001 "Boopa Bagels Customer Card Ext" extends "Customer Card"
{
    /// <summary>
    /// Simple page extension to demonstrate AL-Go functionality
    /// Adds Boopa Bagels specific functionality to Customer Card
    /// </summary>
    
    layout
    {
        addlast(General)
        {
            group("Boopa Bagels Info")
            {
                Caption = 'Boopa Bagels Information';
                
                field("Bakery Customer"; "Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bakery Customer Name';
                    ToolTip = 'Shows the customer name with Boopa Bagels branding';
                    Editable = false;
                }
            }
        }
    }
    
    actions
    {
        addlast(Navigation)
        {
            group("Boopa Bagels Actions")
            {
                Caption = 'Boopa Bagels';
                Image = Administration;
                
                action("Test Hello World")
                {
                    ApplicationArea = All;
                    Caption = 'Test Hello World';
                    Image = TestFile;
                    ToolTip = 'Test the Hello World functionality';
                    
                    trigger OnAction()
                    var
                        HelloWorld: Codeunit "Boopa Bagels Hello World";
                    begin
                        Message(HelloWorld.SayHello());
                    end;
                }
                
                action("View Error Intelligence")
                {
                    ApplicationArea = All;
                    Caption = 'Error Intelligence Console';
                    Image = ErrorLog;
                    ToolTip = 'Open the Error Intelligence console';
                    
                    trigger OnAction()
                    var
                        ErrorLogPage: Page "Boopa Bagels API Test Console";
                    begin
                        ErrorLogPage.Run();
                    end;
                }
            }
        }
    }
}
