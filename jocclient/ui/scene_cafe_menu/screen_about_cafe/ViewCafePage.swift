import UIKit

class ViewCafePage:BaseViewController
{
    var vm_cafe_page:VmCafePage!
    var factory_cafe_page:FactoryCafePage!
    var reviews:[ModelReview] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_cafe_page)
        factory_cafe_page = FactoryCafePage(vc: self)
        
        setEvents()
        setListeners()
        factory_cafe_page.tb_reviews.delegate = self
        factory_cafe_page.tb_reviews.dataSource = self
    }
    
    private func setListeners()
    {
        factory_cafe_page.img_arrow_back.addAction {
            self.vm_cafe_page.clickedArrowBack()
        }
    }
    
    private func setEvents()
    {
        vm_cafe_page.br_cafe
            .subscribe(onNext:
                { cafe in
                    
                    if let cafe = cafe
                    {
                        self.bindCafe(cafe: cafe)
                    }
            })
            .disposed(by: dispose_bag)
    }
    
    private func bindCafe(cafe:ModelCafe)
    {
        if let url = cafe.logo?.url_m
        {
            factory_cafe_page.view_cafe_logo.img.loadImageMy(url_str: url)
        }
        
        factory_cafe_page.lbl_name.text = cafe.name
        factory_cafe_page.rating.rating = cafe.rating ?? 0.0
        factory_cafe_page.tf_description.text = cafe.description
        factory_cafe_page.lbl_adress.text = cafe.address
        factory_cafe_page.lbl_time.text = cafe.working_hours_str
        factory_cafe_page.lbl_distance.text = cafe.getDistanseText()
        
        if factory_cafe_page.tf_description.getNumberOfLines() < 2
        {
            let text = (cafe.description ?? "")+"\n"
            factory_cafe_page.tf_description.text = text
        }
        
        bind_images(images: cafe.images ?? [])
        
        factory_cafe_page.view_top.myla()
        let grad_view = MyColors.gi.getOrangeGradient(horizontal: true)
        grad_view.frame = factory_cafe_page.view_top.bounds
        factory_cafe_page.view_top.layer.insertSublayer(grad_view,at: 0)
        
        self.reviews = cafe.reviews ?? []
        self.factory_cafe_page.tb_reviews.reloadData()
    }
    
    func bind_images(images:[BaseImage])
    {
        factory_cafe_page.scroll_image.removeAllSubviews()
        var left_anchor = factory_cafe_page.scroll_image.snp.left
        
        images.forEach(
            { image in
                
                let img_stroked = ImgSquareStroked()
                if let url = image.url_m
                {
                    img_stroked.img.loadImageMy(url_str: url)
                }
                factory_cafe_page.scroll_image.addSubview(img_stroked)
                
                img_stroked.snp.makeConstraints(
                    { make in
                        
                        make.width.height.equalTo(FactoryCafePage.square_img_size)
                        make.centerY.equalToSuperview()
                        make.left.equalTo(left_anchor).offset(8)
                })
                
                img_stroked.addAction {
                    self.vm_cafe_page.clickedImage(image: image)
                }
                
                left_anchor = img_stroked.snp.right
        })
        
        factory_cafe_page.scroll_image.resizeContentToFitHorizontal(offset: 8)
        
        var height = FactoryCafePage.square_img_size
        if(images.count == 0)
        {
            height = 0
        }
        
        factory_cafe_page.scroll_image.snp.updateConstraints(
            { updater in
                
                updater.height.equalTo(height)
        })
    }
}

extension ViewCafePage:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let review = reviews[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReview.reuse_id) as! CellReview
        cell.bindReview(review: review)
        
        return cell
    }
}
