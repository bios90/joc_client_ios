import UIKit

class ViewCafePage:BaseViewController
{
    var vm_cafe_page:VmCafePage!
    var factory_cafe_page:FactoryCafePage!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_cafe_page)
        factory_cafe_page = FactoryCafePage(vc: self)
        
        setEvents()
    }
    
    private func setEvents()
    {
        vm_cafe_page.vm_cafe
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
        factory_cafe_page.lbl_description.text = cafe.description
        factory_cafe_page.lbl_adress.text = cafe.address
        factory_cafe_page.lbl_time.text = cafe.working_hours_str
        factory_cafe_page.lbl_distance.text = cafe.getDistanseText()
        
        if factory_cafe_page.lbl_description.getNumberOfLines() < 2
        {
            let text = (cafe.description ?? "")+"\n"
            factory_cafe_page.lbl_description.text = text
        }
        
        bind_images(images: cafe.images ?? [])
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
