page 50001 "BoopaBagels API Test Console"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    Caption = 'BoopaBagels API Test Console';

    layout
    {
        area(Content)
        {
            group(Configuration)
            {
                Caption = 'API Configuration';
                field(BaseUrl; BaseUrl)
                {
                    ApplicationArea = All;
                    Caption = 'Base URL';
                    ToolTip = 'Enter the Business Central API base URL';
                }
            }
            group(TestResults)
            {
                Caption = 'Response Information';
                field(StatusCode; StatusCode)
                {
                    ApplicationArea = All;
                    Caption = 'Status Code';
                    Editable = false;
                    ToolTip = 'HTTP response status code';
                }
                field(ResponseBody; ResponseBody)
                {
                    ApplicationArea = All;
                    Caption = 'Response Body';
                    MultiLine = true;
                    Editable = false;
                    ToolTip = 'HTTP response body content';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TestConnection)
            {
                ApplicationArea = All;
                Caption = 'Test Connection';
                Image = TestFile;
                ToolTip = 'Test the API connection';

                trigger OnAction()
                begin
                    TestAPIConnection();
                end;
            }
        }
    }

    var
        BaseUrl: Text[250];
        StatusCode: Integer;
        ResponseBody: Text;

    local procedure TestAPIConnection()
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
    begin
        try
            if BaseUrl = '' then begin
                Error('Please enter a Base URL');
            end;

            HttpRequestMessage.Method := 'GET';
            HttpRequestMessage.SetRequestUri(BaseUrl + '/api/v2.0/companies');

            if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
                StatusCode := HttpResponseMessage.HttpStatusCode();
                HttpResponseMessage.Content().ReadAs(ResponseText);
                ResponseBody := CopyStr(ResponseText, 1, MaxStrLen(ResponseBody));
                
                if HttpResponseMessage.IsSuccessStatusCode() then begin
                    Message('Connection successful! Status: %1', StatusCode);
                end else begin
                    Error('Connection failed with status code: %1', StatusCode);
                end;
            end else begin
                Error('Failed to send request to %1', BaseUrl);
            end;
        except
            Error('Connection test failed: %1', GetLastErrorText());
        end;
    end;
}
