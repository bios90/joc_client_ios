import UIKit

class ViewProductSettings:BaseViewController
{
    var vm_product_settings:VmProductSettings!
    var factory_product_settings:FactoryProductSettings!
    
    var bubbles_weight:ProductBubbles? = nil
    var bubbles_shugar:ProductBubbles? = nil
    var bubbles_milks:ProductBubbles? = nil
    var bubbles_addables:ProductBubbles? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_product_settings)
        factory_product_settings = FactoryProductSettings(vc: self)
        
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_product_settings
            .br_is_edit_mode
            .subscribe(onNext:
                { is_edit in
                    
                    let text:String
                    if is_edit
                    {
                        text = MyStrings.save.localized()
                    }
                    else
                    {
                        text = MyStrings.add.localized()
                    }
                    
                    self.factory_product_settings.btn_add.br_text.accept(text)
            })
            .disposed(by: dispose_bag)
        
        vm_product_settings.br_product
            .subscribe(onNext:
                { product in
                    
                    self.bindProduct(product: product)
            })
            .disposed(by: dispose_bag)
        
        vm_product_settings.br_basket_item
            .subscribe(onNext:
                { bakset_item in
                    
                    self.bindBaksetItem(basket_item: bakset_item)
            })
            .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_product_settings.btn_add.addAction {
            self.vm_product_settings.clickedAdd()
        }
    }
    
    
    private func bindProduct(product:ModelProduct)
    {
        if let url = product.image?.url_l
        {
            factory_product_settings.img_image.loadImageMy(url_str: url)
        }
        
        factory_product_settings.lbl_name.text = product.name
        factory_product_settings.lbl_description.text = product.description
        
        bindBubbles(product: product)
        recountScreenHeight()
        
        runActionWithDelay(milliseconds: 100, action:
            {
                self.factory_product_settings.view_container.makeRoundCorners(corners: [.topLeft,.topRight], radius: 12.0)
        })
    }
    
    private func bindBubbles(product:ModelProduct)
    {
        var top_anchor = factory_product_settings.scroll_bubbles.snp.top
        
        if let weights = product.weights, weights.count > 0
        {
            bubbles_weight = ProductBubbles()
            bubbles_weight?.lbl_title.text = MyStrings.weight.localized()
            
            bubbles_weight?.bindBubbles(addables: weights)
            
            factory_product_settings.scroll_bubbles.addSubview(bubbles_weight!)
            bubbles_weight?.snp.makeConstraints(
                { make in
                    
                    make.width.centerX.equalToSuperview()
                    make.top.equalTo(top_anchor)
            })
            
            bubbles_weight?.bubbles_view.my_listener =
                { _ in
                    
                    guard let pos = self.bubbles_weight?.bubbles_view.getSelected() else { return }
                    self.vm_product_settings.changedWeight(pos: pos)
            }
            
            top_anchor = bubbles_weight!.snp.bottom
        }
        
        if product.type == TypeProduct.Hot || product.type == TypeProduct.Cold
        {
            bubbles_shugar = ProductBubbles()
            bubbles_shugar?.lbl_title.text = MyStrings.sugar.localized()
            
            bubbles_shugar?.bindBubbles(addables: ModelAddableValue.getSugars())
            
            factory_product_settings.scroll_bubbles.addSubview(bubbles_shugar!)
            bubbles_shugar?.snp.makeConstraints(
                { make in
                    
                    make.width.centerX.equalToSuperview()
                    make.top.equalTo(top_anchor)
            })
            
            bubbles_shugar?.bubbles_view.my_listener =
                { _ in
                    
                    guard let pos = self.bubbles_shugar?.bubbles_view.getSelected() else { return }
                    self.vm_product_settings.changedShugar(shugar: pos)
            }
            
            top_anchor = bubbles_shugar!.snp.bottom
        }
        
        if let milks = product.milks, milks.count > 0
        {
            bubbles_milks = ProductBubbles()
            bubbles_milks?.lbl_title.text = MyStrings.milk.localized()
            
            bubbles_milks?.bindBubbles(addables: milks)
            
            factory_product_settings.scroll_bubbles.addSubview(bubbles_milks!)
            bubbles_milks?.snp.makeConstraints(
                { make in
                    
                    make.width.centerX.equalToSuperview()
                    make.top.equalTo(top_anchor)
            })
            
            bubbles_milks?.bubbles_view.my_listener =
                { _ in
                    
                    let pos = self.bubbles_milks?.bubbles_view.getSelected()
                    self.vm_product_settings?.changedMilk(pos: pos)
            }
            
            bubbles_milks?.bubbles_view.can_zero_select = true
            top_anchor = bubbles_milks!.snp.bottom
        }
        
        if let addables = product.addables, addables.count > 0
        {
            bubbles_addables = ProductBubbles()
            bubbles_addables?.lbl_title.text = MyStrings.addables.localized()
            
            bubbles_addables?.bindBubbles(addables: addables)
            
            factory_product_settings.scroll_bubbles.addSubview(bubbles_addables!)
            bubbles_addables?.snp.makeConstraints(
                { make in
                    
                    make.width.centerX.equalToSuperview()
                    make.top.equalTo(top_anchor)
            })
            
            bubbles_addables?.bubbles_view.my_listener =
                { posses in
                    
                    self.vm_product_settings.changedAddables(poses: posses)
            }
            
            bubbles_addables?.bubbles_view.can_zero_select = true
            bubbles_addables?.bubbles_view.multi_selectable = true
            top_anchor = bubbles_addables!.snp.bottom
        }
    }
    
    private func getAllBubbleHeight()->Int
    {
        var height:CGFloat = 0
        
        bubbles_weight?.myla()
        bubbles_shugar?.myla()
        bubbles_milks?.myla()
        bubbles_addables?.myla()
        
        height += (bubbles_weight?.frame.height ?? 0)
        height += (bubbles_shugar?.frame.height ?? 0)
        height += (bubbles_milks?.frame.height ?? 0)
        height += (bubbles_addables?.frame.height ?? 0)
        
        return Int(height)
    }
    
    private func recountScreenHeight()
    {
        var height:CGFloat = 0
        
        factory_product_settings.view_top.myla()
        factory_product_settings.scroll_bubbles.myla()
        factory_product_settings.view_bottom.myla()
        
        height += factory_product_settings.view_top.frame.height
        height += factory_product_settings.view_bottom.frame.height
        height += CGFloat(getAllBubbleHeight())
        
        let full_screen_height = getScreenHeight()
        
        if(height > full_screen_height - 64)
        {
            height = full_screen_height - 64
        }
        
        factory_product_settings.view_container.snp.updateConstraints(
            { updater in
                
                updater.height.equalTo(height)
        })
        
        factory_product_settings.scroll_bubbles.resizeContentToFit()
    }
    
    private func bindBaksetItem(basket_item:ModelBasketItem)
    {
        if let weight = basket_item.weight,let weights = basket_item.product.weights
        {

            let pos = weights.firstIndex(where:
            { $0.value == weight.value })
            let selected_pos = bubbles_weight?.bubbles_view.getSelected()
            
            if(pos != selected_pos && pos != nil)
            {
                bubbles_weight?.bubbles_view.setSelected(selected: [pos!])
            }
        }
        
        if let bubbles_shugar = bubbles_shugar
        {
            let selected_pos:Int? = bubbles_shugar.bubbles_view.getSelected()
            
            if(basket_item.sugar != selected_pos)
            {
                bubbles_shugar.bubbles_view.setSelected(selected: [basket_item.sugar])
            }
        }
        
        if let milks = basket_item.product.milks
        {
            let selected:Int? = bubbles_milks?.bubbles_view.getSelected()
            
            if let milk = basket_item.milk
            {
                let pos = milks.firstIndex(where:{ $0.value == milk.value })
                
                if pos != selected && pos != nil
                {
                    bubbles_milks?.bubbles_view.setSelected(selected: [pos!])
                }
                else
                {
                    bubbles_milks?.bubbles_view.setSelected(selected: [])
                }
            }
            else
            {
                if selected != nil
                {
                    bubbles_milks?.bubbles_view.setSelected(selected: [])
                }
            }
        }
    
        if let bubbles_addables = bubbles_addables
        {
            let selected_poses = basket_item.getSelectedAddablesPoses()
            bubbles_addables.bubbles_view.setSelected(selected: selected_poses)
        }
        
        bindPrices(bakset_item: basket_item)
    }
    
    private func bindPrices(bakset_item:ModelBasketItem)
    {
        let price_weight =  bakset_item.weight?.price ?? 0.0
        let price_text_weight = price_weight.formatWithPattern(format: .formatForPrice) + " р"
        bubbles_weight?.lbl_price.text = price_text_weight
        
        let price_text_shugar = 0.formatWithPattern(format: .formatForPrice) + " р"
        bubbles_shugar?.lbl_price.text = price_text_shugar
        
        let price_milk = bakset_item.milk?.price ?? 0
        let price_text_milks = price_milk.formatWithPattern(format: .formatForPrice) + " р"
        bubbles_milks?.lbl_price.text = price_text_milks
        
        var sum = 0.0
        bakset_item.addables.forEach(
            { addable in
                
                if let price = addable.price
                {
                    sum += price
                }
        })
        
        let price_text_addables = sum.formatWithPattern(format: .formatForPrice) + " р"
        bubbles_addables?.lbl_price.text = price_text_addables
        
        let sum_text = getSumText(sum: bakset_item.getSum())
        factory_product_settings.lbl_sum.attributedText = sum_text
    }
}
