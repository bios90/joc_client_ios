import UIKit
import SwipeViewController

class ViewList:BaseViewController
{
    var vm_list:VmList!
    var factory_list:FactoryList!
    var swipe_controller:SwipeViewController!
    var is_swipe_buttons_setted:Bool = false
    
    var vc_by_distance = ViewCafesListForTb()
    var vc_by_rating = ViewCafesListForTb()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        status_bar_style = .default
        setBaseVmAction(base_vm: vm_list)
        setEvents()
        factory_list = FactoryList(vc: self)
        testTabs()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        swipe_controller.navigationBar.removeBottomLine()
        swipe_controller.navigationBar.addShadowMin()
        if(!is_swipe_buttons_setted)
        {
            resetSwipeControllerButtons()
        }
    }
    
    private func testTabs()
    {
        vc_by_distance.title = MyStrings.by_distance.localized()
        vc_by_rating.title = MyStrings.by_rating.localized()
        
        vc_by_distance.action_clicked_cafe = { self.vm_list.clickedCafe(cafe: $0) }
        vc_by_rating.action_clicked_cafe = { self.vm_list.clickedCafe(cafe: $0) }
        
        swipe_controller = SwipeViewController(pages: [vc_by_distance, vc_by_rating])
        
        swipe_controller.offset = 0
        swipe_controller.leftBarButtonItem = nil
        swipe_controller.buttonColor = MyColors.gi.gray5
        swipe_controller.selectedButtonColor = MyColors.gi.orange
        swipe_controller.buttonFont = MyFonts.gi.bold_s
        swipe_controller.offset = 0
        swipe_controller.equalSpaces = true
        swipe_controller.bottomOffset = 6
        swipe_controller.selectionBarHeight = 0
        swipe_controller.selectionBarWidth =  getScreenWidth() / 2
        swipe_controller.selectionBarColor = MyColors.gi.orange
        
        self.view.addSubview(swipe_controller.view)
        addChild(swipe_controller)
        swipe_controller.didMove(toParent: self)
    }
    
    private func resetSwipeControllerButtons()
    {
        guard !is_swipe_buttons_setted else { return }
        self.view.myla()
        
        for i in 0..<swipe_controller.buttons.count
        {
            let btn = swipe_controller.buttons[i]
            let width = getScreenWidth() / 2
            let frame_now = btn.frame
            btn.frame = CGRect(x: (CGFloat(i) * width) - 8,y: frame_now.minY, width: width,height: frame_now.height)
            btn.myla()
        }
        
        is_swipe_buttons_setted = true
    }
    
    private func setEvents()
    {
        vm_list.br_cafes.subscribe(onNext:
            {cafes in
                
                let by_rating = cafes.sorted(by:
                { cafe_1,cafe_2 in
                    
                    return (cafe_1.rating ?? 0) > (cafe_2.rating ?? 0)
                })
                
                let by_distance = cafes.sorted(by:
                { cafe_1,cafe_2 in
                    
                    return (cafe_1.distance ?? 0) > (cafe_2.distance ?? 0)
                })
                
                self.vc_by_distance.setCafes(cafes: by_distance)
                self.vc_by_rating.setCafes(cafes: by_rating)
        })
            .disposed(by: dispose_bag)
    }
}
