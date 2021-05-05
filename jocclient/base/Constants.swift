import Foundation

class Constants
{
    struct Urls
    {
        static let test_mode = false
        static let URL_BASE:String =
        {
            if(test_mode)
            {
                return "https://dev.justordercompany.com/"
            }
            
            return "https://justordercompany.com/"
        }()
        
        static let API_VERSION = "v1"
        
        static let REGISTER = "api/\(Constants.Urls.API_VERSION)/client/register"
        static let URL_PHONE_CONFIRM = "api/\(Constants.Urls.API_VERSION)/client/confirm"
        static let URL_USER_UPDATE = "api/\(Constants.Urls.API_VERSION)/client/update"
        static let URL_USER_INFO = "api/\(Constants.Urls.API_VERSION)/client/info"
        static let URL_GET_CAFES = "api/\(Constants.Urls.API_VERSION)/cafe/list"
        static let URL_GET_CAFE_SINGLE = "api/\(Constants.Urls.API_VERSION)/cafe/info"
        static let URL_ORDER_CREATE = "api/\(Constants.Urls.API_VERSION)/order/create"
        static let URL_ORDER_PAY = "api/\(Constants.Urls.API_VERSION)/order/payment"
        static let URL_ORDER_CANCEL = "api/\(Constants.Urls.API_VERSION)/order/status-update"
        static let URL_ORDER_GET_INFO = "api/\(Constants.Urls.API_VERSION)/order/info"
        static let URL_ORDER_GET_USER_ORDERS = "api/\(Constants.Urls.API_VERSION)/order/list"
        static let URL_ORDER_MAKE_REVIEW = "api/\(Constants.Urls.API_VERSION)/cafe/review"
    }
    
    struct Payments
    {
        static let API_KEY:String =
        {
            if(Constants.Urls.test_mode)
            {
                return "test_NzI0MDI3O0fCxNm7K8L46XswOyF6e661TFvPCmMGclk"
            }
            
            return "live_NzIxMjY4I2UiYQSiF5Q1IN5dNntIb4ORicC8MElopsU"
        }()
        
        static let SHOP_ID:String =
        {
            if(Constants.Urls.test_mode)
            {
                return "724027"
            }
            
            return "721268"
        }()
    }
}

