import Foundation
import RxSwift
import RxCocoa

class VmTabWrapper:BaseVm
{
    let ps_clicked_filter:PublishSubject<Void> = PublishSubject.init()
    
    override init()
    {
        super.init()
        MyLocationManager.gi.startGettingLocation()
    }
}

//MARK: -Listeners
extension VmTabWrapper
{
    func clickedFilter()
    {
        ps_clicked_filter.onNext(())
    }
}
