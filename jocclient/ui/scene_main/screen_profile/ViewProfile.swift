import UIKit

class ViewProfile:BaseViewController
{
    var vm_profile:VmProfile!
    var factory_profile:FactoryProfile!
    var orders:[ModelOrder] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_profile)
        factory_profile = FactoryProfile(vc: self)
        
        factory_profile.tb_orders_items.delegate = self
        factory_profile.tb_orders_items.dataSource = self
        setEvents()
        setListeners()
    }
    
    private func setListeners()
    {
        (factory_profile.view_auth.tf <-> vm_profile.br_tf_auth_text).disposed(by: dispose_bag)
        
        factory_profile.view_auth.check_box.valueChanged =
            { is_checked in
                
                self.vm_profile.br_offert_checked.accept(is_checked)
        }
        
        factory_profile.view_auth.btn_send.addAction {
            self.vm_profile.clickedAuthSendBtn()
        }
        
        factory_profile.view_auth.btn_i_agree.addAction {
            self.vm_profile.clickedOffertText()
        }
        
        factory_profile.btn_info.addAction {
            self.vm_profile.clickedOffertText()
        }
        
        factory_profile.btn_edit.addAction {
            self.vm_profile.clickedEditProfile()
        }
        
        factory_profile.refresh_control.attributedTitle = NSAttributedString(string: "")
        factory_profile.refresh_control.addTarget(self, action: #selector(swipeTopRefresh), for: .valueChanged)
    }
    
    @objc func swipeTopRefresh(_ sender: Any)
    {
        vm_profile.swipedToRefreshOrders()
    }
    
    private func setEvents()
    {
        vm_profile.br_auth_mode
            .subscribe(onNext:
                { mode in
                    
                    self.factory_profile.view_auth.bindMode(mode: mode)
            })
            .disposed(by: dispose_bag)
        
        vm_profile.br_show_hide_auth
            .subscribe(onNext:
                { show_auth in
                    
                    if(show_auth)
                    {
                        self.factory_profile.view_auth.animateFadeOut()
                    }
                    else
                    {
                        self.factory_profile.view_auth.animateFadeIn()
                    }
            })
            .disposed(by: dispose_bag)
        
        vm_profile.br_user_to_display
            .subscribe(onNext:
                { user in
                    
                    self.bindUser(user: user)
            })
            .disposed(by: dispose_bag)
        
        vm_profile.br_reviews
            .subscribe(onNext:
                { reviews in
                    
                    self.factory_profile.refresh_control.endRefreshing()
                    self.orders = reviews
                    self.factory_profile.tb_orders_items.reloadData()
            })
            .disposed(by: dispose_bag)
    }
    
    private func bindUser(user:ModelUser?)
    {
        factory_profile.lbl_user_name.text = user?.name
        factory_profile.lbl_phone.text = user?.phone
        
        if let count_cups = user?.count_cups
        {
            factory_profile.lbl_cups_count.text = String(count_cups)
        }
        else
        {
            factory_profile.lbl_cups_count.text = "-"
        }
        
        if let count_orders = user?.count_orders
        {
            factory_profile.lbl_orders_count.text = String(count_orders)
        }
        else
        {
            factory_profile.lbl_orders_count.text = "-"
        }
        
        if let reviews_count = user?.count_reviews
        {
            factory_profile.lbl_reviews_count.text = String(reviews_count)
        }
        else
        {
            factory_profile.lbl_reviews_count.text = "-"
        }
        
        if let avatar_url = user?.image?.url_m
        {
            factory_profile.img_avatar.img.loadImageMy(url_str: avatar_url)
        }
    }
}

extension ViewProfile:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let order = orders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellOrder.reuse_id) as! CellOrder
        
        var need_to_show_date = true
        if let previous_date = orders[safe: indexPath.row - 1]?.date,let current_date = order.date
        {
            need_to_show_date = !Calendar.current.isDate(previous_date, inSameDayAs: current_date)
        }
        cell.bindOrder(order: order, need_to_show_date: need_to_show_date)
        
        cell.root_btn.removeClickAction()
        cell.root_btn.addAction {
            self.vm_profile.clickedOrder(order:order)
        }
        
        return cell
    }
    
    
}
