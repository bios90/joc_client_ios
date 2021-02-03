import UIKit
import RxSwift
import RxCocoa

class ViewTabWrapper:BaseTabBarController
{
    var vm_tab_wrapper:VmTabWrapper!
    
    let btn_filter:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_m)
        btn.br_text.accept(FawString.settings.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.layer.cornerRadius = 22
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.orange
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        btn.alpha = 0
        return btn
    }()
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        delegate = self
        self.view.addSubview(btn_filter)
        
        setEvents()
        setListeners()
        
        btn_filter.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(44)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalToSuperview().offset(-64)
        })
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setListeners()
    {
        btn_filter.addAction {
            self.vm_tab_wrapper.clickedFilter()
        }
    }
    
    private func setEvents()
    {
        BusMainEvents.gi.ps_scroll_to_tab
            .subscribe(onNext:
                { tab in
                    
                    self.selectedIndex = tab.getPos()
            })
        .disposed(by: dispose_bag)
    }
}

extension ViewTabWrapper:UITabBarControllerDelegate
{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        let index = tabBar.items?.index(of: item)
        if(index == 0)
        {
            btn_filter.animateFadeIn(duration: 0.15)
        }
        else
        {
            btn_filter.animateFadeOut(duration: 0.15)
        }
    }
}
