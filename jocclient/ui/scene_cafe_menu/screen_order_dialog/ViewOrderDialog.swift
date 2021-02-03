import Foundation
import UIKit

class ViewOrderDialog:BaseViewController,UITextViewDelegate
{
    var vm_order_dialog:VmOrderDialog!
    var factory_order_dialog:FactoryOrderDialog!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_order_dialog)
        factory_order_dialog = FactoryOrderDialog(vc: self)
        
        setEvents()
        setListeners()
        factory_order_dialog.picker_time.date = Date().addingTimeInterval(TimeInterval(5.0 * 60.0))
    }
    
    private func setListeners()
    {
        factory_order_dialog.btn_pay.addAction {
            self.vm_order_dialog.clickedMakeOrder()
        }
        
        factory_order_dialog.picker_time.addTarget(self, action: #selector(datePickerChanged), for: .valueChanged)
        
        
        factory_order_dialog.tv_comment.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView)
    {
        var text:String? = textView.text
        if text?.isEmpty ?? false
        {
            text = nil
        }
        vm_order_dialog.br_comment.accept(text)
    }
    
    @objc func datePickerChanged(sender:UIDatePicker)
    {
        let date = sender.date
        vm_order_dialog.br_date.accept(date)
    }
    
    private func setEvents()
    {
        vm_order_dialog.br_cafe
            .subscribe(onNext:
                { cafe in
                    
                    if let cafe = cafe
                    {
                        self.bindCafe(cafe: cafe)
                    }
            })
        .disposed(by: dispose_bag)
        
        vm_order_dialog.br_price
            .subscribe(onNext:
            { sum in
                
                let sum_text = getSumText(sum: sum)
                self.factory_order_dialog.lbl_sum.attributedText = sum_text
        })
        .disposed(by: dispose_bag)
    }
    
    private func bindCafe(cafe:ModelCafe)
    {
        if let url = cafe.logo?.url_m
        {
            factory_order_dialog.view_logo.img.loadImageMy(url_str: url)
        }
        
        factory_order_dialog.lbl_name.text = cafe.name
        factory_order_dialog.lbl_adress.text = cafe.address
        factory_order_dialog.lbl_time.text = cafe.working_hours_str
        
    }
}
