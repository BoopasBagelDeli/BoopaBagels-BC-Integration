codeunit 50002 "Boopa Bagels Hello World"
{
    /// <summary>
    /// Simple Hello World codeunit to demonstrate AL-Go functionality
    /// </summary>
    
    procedure SayHello(): Text
    begin
        exit('Hello from Boopa Bagels Error Intelligence Extension!');
    end;
    
    procedure GetWelcomeMessage(): Text
    begin
        exit('Welcome to Boopa Bagels Business Central Integration - Your bakery operations just got smarter!');
    end;
    
    procedure TestErrorIntelligence()
    var
        ErrorIntelligence: Codeunit "Boopa Bagels Error Intelligence";
    begin
        // Test integration with our error intelligence system
        ErrorIntelligence.LogError('TEST001', 'Hello World Test', 'Testing AL-Go integration', 'TEST');
    end;
    
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure OnCompanyInitialize()
    begin
        Message(GetWelcomeMessage());
    end;
}
