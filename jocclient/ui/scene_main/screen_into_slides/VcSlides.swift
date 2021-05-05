import UIKit

class VcSlides:UIViewController
{
    static let slide_screen_height = 648
    
    static func showSlides()
    {
        let vc = VcSlides()
        vc.modalPresentationStyle = .overCurrentContext
        getTopViewController().present(vc, animated: false, completion: nil)
    }
    
    var views:[UIView] = []
    
    let view_container:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let pager_control:UIPageControl =
    {
        let page_control = UIPageControl()
        //        page_control.backgroundColor = MyColors.getInstance.pink.withAlphaComponent(0.5)
        page_control.pageIndicatorTintColor =  MyColors.gi.orange.withAlphaComponent(0.5)
        page_control.currentPageIndicatorTintColor = MyColors.gi.orange
        return page_control
    }()
    
    let btn_skip :BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.reg_s)
        btn.br_text.accept(MyStrings.skip.localized())
        btn.br_text_color.accept(MyColors.gi.gray5)
        return btn
    }()
    
    let btn_futher :BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.reg_s)
        btn.br_text.accept(MyStrings.futher.localized())
        btn.br_text_color.accept(MyColors.gi.gray5)
        return btn
    }()
    
    let btn_start :BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.reg_m)
        btn.br_text.accept(MyStrings.start.localized())
        btn.br_text_color.accept(MyColors.gi.orange)
        btn.alpha = 0
        return btn
    }()
    
    let cv_layout:UICollectionViewFlowLayout =
    {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let width = getScreenWidth() - 48
        let height = VcSlides.slide_screen_height
        layout.itemSize = CGSize(width: Int(width), height: Int(height))
        return layout
    }()
    
    var cv_slides:UICollectionView!
    var slides:[ModelSlideData] = ModelSlideData.getSlidesData()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        slides.forEach(
            { data in
                
                let view = ViewSlide()
                view.bindSlideData(data: data)
                views.append(view)
        })
        
        setupViews()
    }
    
    func setupViews()
    {
        self.view.backgroundColor = MyColors.gi.black.withAlphaComponent(0.4)
        
        cv_slides = UICollectionView(frame: CGRect.zero,collectionViewLayout: cv_layout)
        cv_slides.isPagingEnabled = true
        cv_slides.register(CellTabView.self, forCellWithReuseIdentifier: CellTabView.reuse_id)
        cv_slides.backgroundColor = MyColors.gi.white
        cv_slides.showsHorizontalScrollIndicator = false
        cv_slides.bounces = false
        
        cv_slides.delegate = self
        cv_slides.dataSource = self
        
        self.view.addSubview(view_container)
        view_container.addSubview(cv_slides)
        view_container.addSubview(pager_control)
        view_container.addSubview(btn_skip)
        view_container.addSubview(btn_start)
        view_container.addSubview(btn_futher)
        
        view_container.snp.makeConstraints(
            { make in
                
                make.width.equalTo(getScreenWidth() - 48)
                make.height.equalTo(VcSlides.slide_screen_height)
                make.center.equalToSuperview()
        })
        
        cv_slides.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        btn_skip.snp.makeConstraints(
            { make in
                
                make.height.equalTo(44)
                make.width.equalToSuperview().multipliedBy(0.4)
                make.left.equalToSuperview()
                make.bottom.equalToSuperview()
        })
        
        btn_start.snp.makeConstraints(
            { make in
                
                make.height.equalTo(44)
                make.width.equalToSuperview().multipliedBy(0.3)
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
        })
        
        btn_futher.snp.makeConstraints(
            { make in
                
                make.height.equalTo(44)
                make.width.equalToSuperview().multipliedBy(0.4)
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
        })
        
        
        pager_control.snp.makeConstraints(
            { make in
                
                make.height.equalTo(32)
                make.width.equalTo(250)
                make.bottom.equalTo(btn_start.snp.top).offset(-12)
                make.centerX.equalToSuperview()
        })
        
        cv_slides.reloadData()
        
        btn_start.addAction {
            self.dismiss(animated: true, completion: nil)
        }
        
        btn_skip.addAction {
            self.dismiss(animated: true, completion: nil)
        }
        
        btn_futher.addAction {
            if let pos = self.cv_slides.getFirstVisiblePos(), pos < self.views.count - 1
            {
                self.cv_slides.scrollToItem(at: IndexPath(row: pos+1, section: 0), at: .centeredHorizontally, animated: true)
            }
        }
    }
}

extension VcSlides:UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        let count = views.count
        pager_control.numberOfPages = count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellTabView.reuse_id, for: indexPath) as! CellTabView
        let view = views[indexPath.row]
        cell.setView(view: view)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        handleScroll()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView)
    {
        handleScroll()
    }
    
    func handleScroll()
    {
        let page = Int(cv_slides.contentOffset.x) / Int(cv_slides.frame.width)
        
        if(page == views.count - 1)
        {
            btn_skip.animateFadeIn()
            btn_futher.animateFadeIn()
            btn_start.animateFadeOut()
        }
        else
        {
            btn_skip.animateFadeOut()
            btn_futher.animateFadeOut()
            btn_start.animateFadeIn()
        }
        
        pager_control.currentPage = page
    }
    
}
