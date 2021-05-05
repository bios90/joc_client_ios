import Foundation
import YooKassaPayments
import YooKassaPaymentsApi

class PaymentManager
{
    static let gi = PaymentManager()
    
    var action_success_tokenization: ((String,PaymentMethodType)->())? = nil
    var action_3d_secure:(()->())?
    var payment_vc:TokenizationModuleInput?
    
    private var action_success_final:((Int)->())? = nil
    
    func createOrder(base_vm:BaseVm, date:Date,comment:String?,action_success:@escaping((Int)->()))
    {
        self.action_success_final = action_success
        let items = BasketManager.gi.br_bakset_items.value.toServerBaksetItems()
        
        if( items.count == 0)
        {
            MessagesManager.showRedAlerter(text: MyStrings.basket_is_empty.localized())
            return
        }
        
        guard let items_str = toJsonMy(from: items)else { return }
        let date_str = date.formatToString(format: DateManager.FORMAT_FOR_SERVER)
        let methods:PaymentMethodTypes = .bankCard
        
        let sum = BasketManager.gi.getSum()
        
        if let order_id = BasketManager.gi.order_id
        {
            self.makePayWithMethod(sum: sum, base_vm: base_vm, payment_methods: methods, order_id: order_id)
        }
        else
        {
            base_vm.base_netwoker.makeOrder(date: date_str, comment: comment, items: items_str, action_success:
                { order_id in
                    
                    self.makePayWithMethod(sum: sum, base_vm: base_vm, payment_methods: methods, order_id: order_id)
            }, action_error:
                { _ in
                      
                    self.dismissPaymentController()
            })
        }
    }
    
    private func makePayWithMethod( sum:Double, base_vm:BaseVm,payment_methods:PaymentMethodTypes,order_id:Int)
    {
        self.action_success_tokenization =
            { token, payment_type in
                
                base_vm.base_netwoker.makePay(order_id:order_id,payment_token: token,action_success:
                    { pay_data in
                        if let confirmation_url = pay_data.confirmation_url, !confirmation_url.isEmpty
                        {
                            self.show3dSecure(url: confirmation_url, action_3d_secure:
                                {
                                    self.dismissPaymentController()
                                    self.action_success_final?(order_id)
                            })
                        }
                        else
                        {
                            self.dismissPaymentController()
                            self.action_success_final?(order_id)
                        }
                },action_error:
                    { _ in
                          
                        self.dismissPaymentController()
                })
        }
        
        //Todo later change for real
        let amount = Amount(value: Decimal(sum), currency: .rub)
//        let amount = Amount(value: 50.0, currency: .rub)
        let title = MyStrings.payment.localized()
        let message = MyStrings.order_in_app_joc.localized()
        
        let color_settings = CustomizationSettings(mainScheme: MyColors.gi.red)
        let settings = TokenizationSettings(paymentMethodTypes: payment_methods, showYooKassaLogo: true)
        
        let tokenization_data = TokenizationModuleInputData(clientApplicationKey: Constants.Payments.API_KEY, shopName: title, purchaseDescription: message, amount: amount, tokenizationSettings: settings, customizationSettings: color_settings, savePaymentMethod: .off)
        let input_data: TokenizationFlow = .tokenization(tokenization_data)
        
        let view_controller = TokenizationAssembly.makeModule(inputData: input_data, moduleOutput: self)
        
        let top_vc = getTopViewController()
        top_vc.present(view_controller, animated: true, completion: nil)
        self.payment_vc = view_controller
    }
    
    
    func show3dSecure(url:String,action_3d_secure:(()->())?)
    {
        guard let secureVc = self.payment_vc else
        {
            return
        }
        self.action_3d_secure = action_3d_secure
        secureVc.start3dsProcess(requestUrl: url)
    }
    
    func dismissPaymentController()
    {
        if let payment_vc = self.payment_vc,let vc = payment_vc as? UIViewController
        {
            vc.dismiss(animated: true, completion: nil)
        }
    }
}


extension PaymentManager:TokenizationModuleOutput
{
    func didFinish(on module: TokenizationModuleInput, with error: YooKassaPaymentsError?)
    {
        
        DispatchQueue.main.async(
            execute: { [weak self] in
                
                //                self?.action_error?(error)
                //                self?.action_error = nil
        })
        
        runActionWithDelay(milliseconds: 100, action:
            {
                self.dismissPaymentController()
        })
    }
    
    
    func didSuccessfullyPassedCardSec(on module: TokenizationModuleInput)
    {
        DispatchQueue.main.async(
            execute:{ [weak self] in
                self?.action_3d_secure?()
                self?.action_3d_secure = nil
        })
    }
    
    func tokenizationModule(_ module: TokenizationModuleInput, didTokenize token: Tokens, paymentMethodType: PaymentMethodType)
    {
        print("Success payment")
        DispatchQueue.main.async
            { [weak self] in
                
                let token_text = token.paymentToken
                self?.action_success_tokenization?(token_text,paymentMethodType)
                self?.action_success_tokenization = nil
        }
    }
}
