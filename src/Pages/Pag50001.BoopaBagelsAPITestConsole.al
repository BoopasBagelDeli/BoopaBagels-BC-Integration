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
                field(CompanyId; CompanyId)
                {
                    ApplicationArea = All;
                    Caption = 'Company ID';
                    ToolTip = 'Enter the Company ID (GUID)';
                }
                field(AuthMethod; AuthMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Authentication Method';
                    ToolTip = 'Select the authentication method';
                }
                field(ClientId; ClientId)
                {
                    ApplicationArea = All;
                    Caption = 'Client ID';
                    ToolTip = 'Enter the OAuth 2.0 Client ID';
                }
                field(TenantId; TenantId)
                {
                    ApplicationArea = All;
                    Caption = 'Tenant ID';
                    ToolTip = 'Enter the Azure AD Tenant ID';
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
                ToolTip = 'Test the API connection with current settings';

                trigger OnAction()
                begin
                    TestAPIConnection();
                end;
            }
        }
    }

    var
        BaseUrl: Text[250];
        CompanyId: Text[50];
        AuthMethod: Text[50];
        ClientId: Text[100];
        TenantId: Text[100];
        StatusCode: Integer;
        ResponseBody: Text;

    local procedure TestAPIConnection()
    var
        HttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        ResponseText: Text;
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
    begin
        try
            if BaseUrl = '' then
                Error('Please enter a Base URL');

            HttpRequestMessage.Method := 'GET';
            HttpRequestMessage.SetRequestUri(BaseUrl + '/api/v2.0/companies');

            if HttpClient.Send(HttpRequestMessage, HttpResponseMessage) then begin
                StatusCode := HttpResponseMessage.HttpStatusCode();
                HttpResponseMessage.Content().ReadAs(ResponseText);
                ResponseBody := CopyStr(ResponseText, 1, MaxStrLen(ResponseBody));
                
                if HttpResponseMessage.IsSuccessStatusCode() then
                    Message('Connection successful! Status: %1', StatusCode)
                else begin
                    ErrorIntelligence.LogError(
                        'API_CONNECTION_FAILED',
                        StrSubstNo('HTTP %1: Connection test failed', StatusCode),
                        ResponseText,
                        'TestAPIConnection',
                        BaseUrl);
                    Error('Connection failed with status code: %1', StatusCode);
                end;
            end else begin
                ErrorIntelligence.LogError(
                    'API_CONNECTION_ERROR',
                    'Failed to send HTTP request',
                    'Unable to establish connection',
                    'TestAPIConnection',
                    BaseUrl);
                Error('Failed to send request to %1', BaseUrl);
            end;
        except
            ErrorIntelligence.LogError(
                'API_CONNECTION_EXCEPTION',
                GetLastErrorText(),
                StrSubstNo('BaseUrl: %1', BaseUrl),
                'TestAPIConnection',
                BaseUrl);
            Error('Connection test failed: %1', GetLastErrorText());
        end;
    end;
}
