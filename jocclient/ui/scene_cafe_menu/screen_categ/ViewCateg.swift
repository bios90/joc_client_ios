import UIKit

class ViewCateg:BaseViewController
{
    var vm_categ:VmCateg!
    var products:[ModelProduct] = []
    
    let view_top:ViewForGradientBg =
    {
        let view = ViewForGradientBg()
        let grad_view = MyColors.gi.getOrangeGradient(horizontal: true)
        grad_view.frame = view.bounds
        view.layer.insertSublayer(grad_view,at: 0)
        return view
    }()
    
    let lbl_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_m
        return lbl
    }()
    
    let img_arrow_back:BtnRipple =
    {
        return ViewsHelper.getArrowBack()
    }()
    
    let tb_products:UITableView =
    {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellProduct.self, forCellReuseIdentifier: CellProduct.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        return tb
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_categ)
        setupViewsMy()
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_categ.br_products
            .subscribe(onNext:
                { products in
                    
                    self.products = products
                    self.tb_products.reloadData()
            })
            .disposed(by: dispose_bag)
        
        vm_categ.br_title
            .subscribe(onNext:
                { title in
                    
                    if let title = title
                    {
                        self.lbl_title.text = title
                    }
            })
            .disposed(by: dispose_bag)
    }
    
    private func setupViewsMy()
    {
        view.backgroundColor = MyColors.gi.white
        tb_products.delegate = self
        tb_products.dataSource = self
        
        self.view.addSubview(view_top)
        view_top.addSubview(lbl_title)
        view_top.addSubview(img_arrow_back)
        self.view.addSubview(tb_products)
        
        view_top.snp.makeConstraints(
            { make in
                
                let height = 56 + getStatusBarHeight()
                make.centerX.width.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(height)
        })
        
        img_arrow_back.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(28)
                make.left.equalToSuperview().offset(10)
                make.bottom.equalToSuperview().offset(-12)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-16)
        })
        
        tb_products.snp.makeConstraints(
            { make in
                
                make.top.equalTo(view_top.snp.bottom)
                make.bottom.equalToSuperview().offset(-12)
                make.left.right.equalToSuperview()
        })
    }
    
    private func setListeners()
    {
        img_arrow_back.addAction {
            self.vm_categ.clickedArrowBack()
        }
    }
}

extension ViewCateg:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellProduct.reuse_id) as! CellProduct
        cell.bindProduct(product: product)
        
        cell.root_btn.removeClickAction()
        cell.root_btn.addAction {
            self.vm_categ.clickedProduct(product: product)
        }
        
        return cell
    }
}
