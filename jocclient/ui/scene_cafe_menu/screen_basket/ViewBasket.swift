import UIKit

class ViewBasket:BaseViewController
{
    var vm_basket:VmBasket!
    var factory_basket:FactoryBasket!
    var basket_items:[ModelBasketItem] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_basket)
        factory_basket = FactoryBasket(vc: self)
        setupTableView()
        
        setEvents()
        setListeners()
    }
    
    private func setupTableView()
    {
        factory_basket.tb_bakset_items.delegate = self
        factory_basket.tb_bakset_items.dataSource = self
    }
    
    private func setEvents()
    {
        vm_basket
            .br_bakset_items
            .subscribe(onNext:
                { items in
                    
                    self.basket_items = items
                    self.factory_basket.tb_bakset_items.reloadData()
                    
                    let sum_text = getSumText(sum: BasketManager.gi.getSum())
                    self.factory_basket.lbl_sum.attributedText = sum_text
            })
            .disposed(by: dispose_bag)
        
        vm_basket
            .br_page_status
            .subscribe(onNext:
                {status in
                    
                    self.rebindToPageStatus(status: status)
            })
            .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_basket.btn_register.addAction {
            self.vm_basket.clickedRegister()
        }
        
        factory_basket.btn_order.addAction {
            self.vm_basket.clickedOrder()
        }
        
        factory_basket.btn_quick_order.addAction {
            self.vm_basket.clickedQuickOrder()
        }
        
        factory_basket.img_arrow_back.addAction {
            self.vm_basket.clickedArrowBack()
        }
    }
    
    private func rebindToPageStatus(status:TypeBasketPageStatus)
    {
        var bottom_height:CGFloat = 100
        
        factory_basket.view_bottom.removeAllSubviews()
        
        switch status
        {
        case .cafe_not_active:
            
            factory_basket.view_bottom.addSubview(factory_basket.lbl_cafe_not_active)
            factory_basket.lbl_cafe_not_active.snp.makeConstraints(
                { make in
                    
                    make.left.equalToSuperview().offset(12)
                    make.right.equalToSuperview().offset(-12)
                    make.height.equalTo(68)
                    make.bottom.equalToSuperview()
            })
            bottom_height = 68
            
        case .need_to_register:
            
            factory_basket.view_bottom.addSubview(factory_basket.view_need_to_register)
            factory_basket.view_need_to_register.snp.makeConstraints(
                { make in
                    
                    make.left.right.bottom.equalToSuperview()
                    make.top.equalTo(factory_basket.lbl_need_to_register).offset(-12)
            })
            
            factory_basket.view_need_to_register.myla()
            bottom_height = factory_basket.view_need_to_register.frame.height
        case .can_buy:
        
            factory_basket.view_bottom.addSubview(factory_basket.view_offer)
            factory_basket.view_offer.snp.makeConstraints(
                { make in
                    
                    make.left.right.bottom.equalToSuperview()
                    make.top.equalTo(factory_basket.lbl_sum).offset(-12)
            })
            
            factory_basket.btn_order.myla()
            factory_basket.btn_order.layer.fitGradientSublayers(rect: factory_basket.btn_order.frame)
            
            factory_basket.btn_quick_order.myla()
            factory_basket.btn_quick_order.layer.fitGradientSublayers(rect: factory_basket.btn_quick_order.frame)
            
            factory_basket.view_offer.myla()
            bottom_height = factory_basket.view_offer.frame.height
        }
        
        print("height to set is \(bottom_height)")
        factory_basket.view_bottom.snp.makeConstraints(
            { make in
                
                make.height.equalTo(bottom_height)
        })
    }
}

extension ViewBasket:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return basket_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let basket_item = basket_items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellBasketItem.reuse_id) as! CellBasketItem
        cell.bindItem(item: basket_item)
        
        cell.root_btn.removeClickAction()
        cell.root_btn.addAction {
            self.vm_basket.clickedItem(item: basket_item)
        }
        
        return cell
    }
}
