import Foundation
import RxSwift
import RxCocoa

class VmCateg:BaseVm
{
    let vm_wrapper:VmWrapperCafeMenu
    let br_title:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var br_products:BehaviorRelay<[ModelProduct]> = BehaviorRelay.init(value: [])
    let ps_clicked_product:PublishSubject<ModelProduct> = PublishSubject.init()
    
    init(vm_wrapper_cafe_menu:VmWrapperCafeMenu)
    {
        self.vm_wrapper = vm_wrapper_cafe_menu
        super.init()
        
        setEvents()
    }
    
    private func setEvents()
    {
        br_products
            .subscribe(onNext:
                { products in
                    
                    if(products.count > 0)
                    {
                        let title = products[0].type?.getNameForDisplay()
                        self.br_title.accept(title)
                    }
            })
        .disposed(by: dispose_bag)
    }
}

//MARK: - Listeners
extension VmCateg
{
    func clickedProduct(product:ModelProduct)
    {
        ps_clicked_product.onNext(product)
    }
}
