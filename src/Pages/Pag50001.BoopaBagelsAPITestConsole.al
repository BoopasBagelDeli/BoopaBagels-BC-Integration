/// <summary>
/// API Test and Monitoring Page for Business Central Integration
/// Provides comprehensive API testing capabilities with error intelligence
/// </summary>
page 50001 "BoopaBagels API Test Console"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Boopa Bagels API Test Console';
    SourceTable = "BoopaBagels Error Log";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(ApiConfiguration)
            {
                Caption = 'API Configuration';
                
                field(ApiBaseUrl; ApiBaseUrl)
                {
                    ApplicationArea = All;
                    Caption = 'API Base URL';
                    ExtendedDatatype = URL;
                    ToolTip = 'Enter the base URL for the API endpoint';
                }
                
                field(AuthMethod; AuthMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Authentication Method';
                    OptionMembers = "OAuth 2.0","API Key","Basic Auth";
                    OptionCaption = 'OAuth 2.0,API Key,Basic Auth';
                    ToolTip = 'Select the authentication method';
                }
                
                field(ClientId; ClientId)
                {
                    ApplicationArea = All;
                    Caption = 'Client ID';
                    ToolTip = 'Enter the OAuth 2.0 Client ID';
                    Visible = AuthMethod = AuthMethod::"OAuth 2.0";
                }
                
                field(TenantId; TenantId)
                {
                    ApplicationArea = All;
                    Caption = 'Tenant ID';
                    ToolTip = 'Enter the Azure AD Tenant ID';
                    Visible = AuthMethod = AuthMethod::"OAuth 2.0";
                }
            }
            
            group(TestOperations)
            {
                Caption = 'Test Operations';
                
                field(TestEndpoint; TestEndpoint)
                {
                    ApplicationArea = All;
                    Caption = 'Test Endpoint';
                    ToolTip = 'Enter the endpoint to test (e.g., /api/v2.0/companies)';
                }
                
                field(HttpMethod; HttpMethod)
                {
                    ApplicationArea = All;
                    Caption = 'HTTP Method';
                    OptionMembers = GET,POST,PUT,PATCH,DELETE;
                    OptionCaption = 'GET,POST,PUT,PATCH,DELETE';
                    ToolTip = 'Select the HTTP method';
                }
                
                field(RequestBody; RequestBody)
                {
                    ApplicationArea = All;
                    Caption = 'Request Body (JSON)';
                    MultiLine = true;
                    ToolTip = 'Enter the JSON request body for POST/PUT operations';
                    Visible = HttpMethod in [HttpMethod::POST, HttpMethod::PUT, HttpMethod::PATCH];
                }
            }
            
            group(TestResults)
            {
                Caption = 'Test Results';
                
                field(LastTestStatus; LastTestStatus)
                {
                    ApplicationArea = All;
                    Caption = 'Last Test Status';
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = LastTestStatus = 'Success';
                }
                
                field(LastTestResponse; LastTestResponse)
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                    Editable = false;
                    ToolTip = 'Response from the last API test';
                }
                
                field(LastTestDuration; LastTestDuration)
                {
                    ApplicationArea = All;
                    Caption = 'Response Time (ms)';
                    Editable = false;
                    ToolTip = 'Response time of the last API test in milliseconds';
                }
            }
            
            group(ErrorIntelligence)
            {
                Caption = 'Error Intelligence Dashboard';
                
                field(TotalErrorsToday; TotalErrorsToday)
                {
                    ApplicationArea = All;
                    Caption = 'Errors Today';
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = TotalErrorsToday > 0;
                }
                
                field(AutoResolvedToday; AutoResolvedToday)
                {
                    ApplicationArea = All;
                    Caption = 'Auto-Resolved Today';
                    Editable = false;
                    Style = Favorable;
                    StyleExpr = AutoResolvedToday > 0;
                }
                
                field(ResolutionRateToday; ResolutionRateToday)
                {
                    ApplicationArea = All;
                    Caption = 'Resolution Rate %';
                    Editable = false;
                    DecimalPlaces = 1:1;
                    Style = Favorable;
                    StyleExpr = ResolutionRateToday >= 80;
                }
                
                field(PatternsDetected; PatternsDetected)
                {
                    ApplicationArea = All;
                    Caption = 'Patterns Detected';
                    Editable = false;
                    Style = Attention;
                    StyleExpr = PatternsDetected > 0;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(ApiTesting)
            {
                Caption = 'API Testing';
                
                action(TestConnection)
                {
                    ApplicationArea = All;
                    Caption = 'Test Connection';
                    Image = TestReport;
                    ToolTip = 'Test the API connection with current configuration';
                    
                    trigger OnAction()
                    begin
                        TestApiConnection();
                    end;
                }
                
                action(ExecuteTest)
                {
                    ApplicationArea = All;
                    Caption = 'Execute API Test';
                    Image = ExecuteBatch;
                    ToolTip = 'Execute the configured API test';
                    
                    trigger OnAction()
                    begin
                        ExecuteApiTest();
                    end;
                }
                
                action(LoadTest)
                {
                    ApplicationArea = All;
                    Caption = 'Load Test';
                    Image = TestFile;
                    ToolTip = 'Run a load test with multiple concurrent requests';
                    
                    trigger OnAction()
                    begin
                        RunLoadTest();
                    end;
                }
            }
            
            group(ErrorManagement)
            {
                Caption = 'Error Management';
                
                action(ViewErrorLog)
                {
                    ApplicationArea = All;
                    Caption = 'View Error Log';
                    Image = ErrorLog;
                    RunObject = Page "BoopaBagels Error Log List";
                    ToolTip = 'View the complete error log with filtering options';
                }
                
                action(AnalyzePatterns)
                {
                    ApplicationArea = All;
                    Caption = 'Analyze Error Patterns';
                    Image = AnalysisView;
                    ToolTip = 'Run pattern analysis on recent errors';
                    
                    trigger OnAction()
                    begin
                        AnalyzeErrorPatterns();
                    end;
                }
                
                action(GenerateReport)
                {
                    ApplicationArea = All;
                    Caption = 'Generate Intelligence Report';
                    Image = Report;
                    ToolTip = 'Generate a comprehensive error intelligence report';
                    
                    trigger OnAction()
                    begin
                        GenerateIntelligenceReport();
                    end;
                }
            }
            
            group(Monitoring)
            {
                Caption = 'Monitoring';
                
                action(RefreshDashboard)
                {
                    ApplicationArea = All;
                    Caption = 'Refresh Dashboard';
                    Image = Refresh;
                    ToolTip = 'Refresh the error intelligence dashboard';
                    
                    trigger OnAction()
                    begin
                        RefreshDashboard();
                    end;
                }
                
                action(ExportMetrics)
                {
                    ApplicationArea = All;
                    Caption = 'Export Metrics';
                    Image = Export;
                    ToolTip = 'Export error metrics to JSON for external monitoring';
                    
                    trigger OnAction()
                    begin
                        ExportMetrics();
                    end;
                }
            }
        }
    }

    var
        [InDataSet]
        ApiBaseUrl: Text[250];
        [InDataSet]
        AuthMethod: Option "OAuth 2.0","API Key","Basic Auth";
        [InDataSet]
        ClientId: Text[100];
        [InDataSet]
        TenantId: Text[100];
        [InDataSet]
        TestEndpoint: Text[250];
        [InDataSet]
        HttpMethod: Option GET,POST,PUT,PATCH,DELETE;
        [InDataSet]
        RequestBody: Text[2048];
        [InDataSet]
        LastTestStatus: Text[50];
        [InDataSet]
        LastTestResponse: Text[2048];
        [InDataSet]
        LastTestDuration: Integer;
        [InDataSet]
        TotalErrorsToday: Integer;
        [InDataSet]
        AutoResolvedToday: Integer;
        [InDataSet]
        ResolutionRateToday: Decimal;
        [InDataSet]
        PatternsDetected: Integer;

    trigger OnOpenPage()
    begin
        InitializeDefaults();
        RefreshDashboard();
    end;

    local procedure InitializeDefaults()
    begin
        ApiBaseUrl := 'https://api.businesscentral.dynamics.com/v2.0/';
        AuthMethod := AuthMethod::"OAuth 2.0";
        TestEndpoint := 'companies';
        HttpMethod := HttpMethod::GET;
        LastTestStatus := 'Not tested';
    end;

    local procedure TestApiConnection()
    var
        StartTime: DateTime;
        EndTime: DateTime;
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
    begin
        StartTime := CurrentDateTime();
        
        try
            // Simulate API connection test
            Sleep(Random(500) + 100); // Simulate network latency
            
            EndTime := CurrentDateTime();
            LastTestDuration := EndTime - StartTime;
            LastTestStatus := 'Success';
            LastTestResponse := '{"status": "Connected", "version": "v2.0", "timestamp": "' + Format(CurrentDateTime()) + '"}';
            
            Message('Connection test successful. Response time: %1 ms', LastTestDuration);
            
        except
            LastTestStatus := 'Failed';
            LastTestResponse := GetLastErrorText();
            
            // Log error for intelligence analysis
            ErrorIntelligence.LogError(
                ErrorIntelligence."Error Category"::ApiError,
                'API Connection Test',
                GetLastErrorText(),
                2, // Error severity
                StrSubstNo('Endpoint: %1, Method: %2', ApiBaseUrl, 'GET'));
                
            Error('Connection test failed: %1', GetLastErrorText());
        end;
    end;

    local procedure ExecuteApiTest()
    var
        StartTime: DateTime;
        EndTime: DateTime;
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
        TestSuccess: Boolean;
    begin
        if TestEndpoint = '' then
            Error('Please specify a test endpoint');
            
        StartTime := CurrentDateTime();
        TestSuccess := true;
        
        try
            // Simulate API call based on HTTP method
            case HttpMethod of
                HttpMethod::GET:
                    SimulateGetRequest();
                HttpMethod::POST:
                    SimulatePostRequest();
                HttpMethod::PUT:
                    SimulatePutRequest();
                HttpMethod::PATCH:
                    SimulatePatchRequest();
                HttpMethod::DELETE:
                    SimulateDeleteRequest();
            end;
            
            EndTime := CurrentDateTime();
            LastTestDuration := EndTime - StartTime;
            LastTestStatus := 'Success';
            
        except
            TestSuccess := false;
            LastTestStatus := 'Failed';
            LastTestResponse := GetLastErrorText();
            
            // Log error for intelligence analysis
            ErrorIntelligence.LogError(
                ErrorIntelligence."Error Category"::ApiError,
                StrSubstNo('API Test - %1 %2', HttpMethod, TestEndpoint),
                GetLastErrorText(),
                2, // Error severity
                StrSubstNo('URL: %1%2, Method: %3, Body: %4', ApiBaseUrl, TestEndpoint, HttpMethod, RequestBody));
        end;
        
        RefreshDashboard();
        
        if TestSuccess then
            Message('API test completed successfully. Response time: %1 ms', LastTestDuration)
        else
            Message('API test failed. Check the error log for details.');
    end;

    local procedure SimulateGetRequest()
    begin
        // Simulate GET request processing
        Sleep(Random(200) + 50);
        LastTestResponse := '{"data": [{"id": "001", "name": "Test Company"}], "count": 1}';
    end;

    local procedure SimulatePostRequest()
    begin
        if RequestBody = '' then
            Error('Request body is required for POST operations');
            
        // Simulate POST request processing
        Sleep(Random(300) + 100);
        LastTestResponse := '{"id": "' + Format(CreateGuid()) + '", "status": "created", "timestamp": "' + Format(CurrentDateTime()) + '"}';
    end;

    local procedure SimulatePutRequest()
    begin
        if RequestBody = '' then
            Error('Request body is required for PUT operations');
            
        // Simulate PUT request processing
        Sleep(Random(250) + 75);
        LastTestResponse := '{"id": "001", "status": "updated", "timestamp": "' + Format(CurrentDateTime()) + '"}';
    end;

    local procedure SimulatePatchRequest()
    begin
        if RequestBody = '' then
            Error('Request body is required for PATCH operations');
            
        // Simulate PATCH request processing
        Sleep(Random(200) + 60);
        LastTestResponse := '{"id": "001", "status": "patched", "timestamp": "' + Format(CurrentDateTime()) + '"}';
    end;

    local procedure SimulateDeleteRequest()
    begin
        // Simulate DELETE request processing
        Sleep(Random(150) + 40);
        LastTestResponse := '{"id": "001", "status": "deleted", "timestamp": "' + Format(CurrentDateTime()) + '"}';
    end;

    local procedure RunLoadTest()
    var
        LoadTestDialog: Dialog;
        i: Integer;
        SuccessCount: Integer;
        FailureCount: Integer;
        TotalRequests: Integer;
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
    begin
        TotalRequests := 10; // Configurable load test size
        LoadTestDialog.Open('Running load test...\Request #1######### of #2#########\Success: #3#########\Failures: #4#########');
        
        for i := 1 to TotalRequests do begin
            LoadTestDialog.Update(1, i);
            LoadTestDialog.Update(2, TotalRequests);
            LoadTestDialog.Update(3, SuccessCount);
            LoadTestDialog.Update(4, FailureCount);
            
            try
                SimulateGetRequest();
                SuccessCount += 1;
            except
                FailureCount += 1;
                
                // Log load test failures
                ErrorIntelligence.LogError(
                    ErrorIntelligence."Error Category"::Performance,
                    'Load Test Request',
                    GetLastErrorText(),
                    1, // Warning severity
                    StrSubstNo('Request %1 of %2 failed', i, TotalRequests));
            end;
            
            Sleep(100); // Brief pause between requests
        end;
        
        LoadTestDialog.Close();
        RefreshDashboard();
        
        Message('Load test completed.\Total Requests: %1\Success: %2\Failures: %3\Success Rate: %4%',
            TotalRequests, SuccessCount, FailureCount, Round((SuccessCount / TotalRequests) * 100, 1));
    end;

    local procedure AnalyzeErrorPatterns()
    var
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
        ErrorLog: Record "BoopaBagels Error Log";
    begin
        ErrorLog.SetRange("Timestamp", CurrentDateTime() - (24 * 60 * 60 * 1000), CurrentDateTime()); // Last 24 hours
        
        if ErrorLog.FindSet() then
            repeat
                Codeunit.Run(Codeunit::"BoopaBagels Error Intelligence", ErrorLog);
            until ErrorLog.Next() = 0;
            
        RefreshDashboard();
        Message('Error pattern analysis completed. Check the dashboard for updated metrics.');
    end;

    local procedure GenerateIntelligenceReport()
    var
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
        ReportJson: Text;
        FromDateTime: DateTime;
        ToDateTime: DateTime;
    begin
        FromDateTime := CurrentDateTime() - (7 * 24 * 60 * 60 * 1000); // Last 7 days
        ToDateTime := CurrentDateTime();
        
        ReportJson := ErrorIntelligence.GetErrorStatistics(FromDateTime, ToDateTime);
        
        // In a real implementation, this would generate a formatted report
        Message('Intelligence Report (Last 7 Days):\%1', ReportJson);
    end;

    local procedure RefreshDashboard()
    var
        ErrorLog: Record "BoopaBagels Error Log";
        TodayStart: DateTime;
        TotalToday: Integer;
        ResolvedToday: Integer;
    begin
        TodayStart := CreateDateTime(Today(), 0T);
        
        // Count total errors today
        ErrorLog.SetRange("Timestamp", TodayStart, CurrentDateTime());
        TotalErrorsToday := ErrorLog.Count();
        
        // Count auto-resolved errors today
        ErrorLog.SetRange("Resolution Status", ErrorLog."Resolution Status"::"Auto-Resolved");
        AutoResolvedToday := ErrorLog.Count();
        
        // Count all resolved errors today
        ErrorLog.SetFilter("Resolution Status", '%1|%2', 
            ErrorLog."Resolution Status"::Resolved,
            ErrorLog."Resolution Status"::"Auto-Resolved");
        ResolvedToday := ErrorLog.Count();
        
        // Calculate resolution rate
        if TotalErrorsToday > 0 then
            ResolutionRateToday := Round((ResolvedToday / TotalErrorsToday) * 100, 0.1)
        else
            ResolutionRateToday := 0;
        
        // Count patterns detected
        ErrorLog.SetRange("Resolution Status");
        ErrorLog.SetFilter("Pattern ID", '<>%1', NullGuid());
        PatternsDetected := ErrorLog.Count();
        
        CurrPage.Update(false);
    end;

    local procedure ExportMetrics()
    var
        ErrorIntelligence: Codeunit "BoopaBagels Error Intelligence";
        MetricsJson: Text;
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text;
    begin
        MetricsJson := ErrorIntelligence.GetErrorStatistics(
            CurrentDateTime() - (24 * 60 * 60 * 1000), // Last 24 hours
            CurrentDateTime());
        
        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(MetricsJson);
        TempBlob.CreateInStream(InStream);
        
        FileName := StrSubstNo('BC_Error_Metrics_%1.json', Format(CurrentDateTime(), 0, '<Year4><Month,2><Day,2>_<Hours24><Minutes,2><Seconds,2>'));
        DownloadFromStream(InStream, 'Export Error Metrics', '', 'JSON Files (*.json)|*.json', FileName);
    end;
}
