/// <summary>
/// Error Categories Enum for comprehensive error classification
/// Following Azure error categorization best practices
/// </summary>
enum 50001 "BoopaBagels Error Category"
{
    Extensible = true;
    Caption = 'Boopa Bagels Error Category';

    value(0; "Unknown")
    {
        Caption = 'Unknown';
    }
    value(1; "Authentication")
    {
        Caption = 'Authentication';
    }
    value(2; "Authorization")
    {
        Caption = 'Authorization';
    }
    value(3; "ApiError")
    {
        Caption = 'API Error';
    }
    value(4; "NetworkTimeout")
    {
        Caption = 'Network Timeout';
    }
    value(5; "RateLimitExceeded")
    {
        Caption = 'Rate Limit Exceeded';
    }
    value(6; "ConfigurationError")
    {
        Caption = 'Configuration Error';
    }
    value(7; "DataValidation")
    {
        Caption = 'Data Validation';
    }
    value(8; "BusinessLogic")
    {
        Caption = 'Business Logic';
    }
    value(9; "Integration")
    {
        Caption = 'Integration';
    }
    value(10; "Performance")
    {
        Caption = 'Performance';
    }
    value(11; "Security")
    {
        Caption = 'Security';
    }
    value(12; "Bakery_Production")
    {
        Caption = 'Bakery Production';
    }
    value(13; "Bakery_Inventory")
    {
        Caption = 'Bakery Inventory';
    }
    value(14; "Bakery_Orders")
    {
        Caption = 'Bakery Orders';
    }
    value(15; "Bakery_Recipe")
    {
        Caption = 'Bakery Recipe';
    }
}
