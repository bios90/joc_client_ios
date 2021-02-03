import Foundation
import RxSwift
import RxCocoa

class VmFilter:BaseVm
{
    let br_min_max:BehaviorRelay<(Int,Int)> = BehaviorRelay.init(value: (0,1000))
    let br_cafe_type:BehaviorRelay<TypeCafe> = BehaviorRelay.init(value: .All)
    let br_rating:BehaviorRelay<Double> = BehaviorRelay.init(value: 4)
    
    override init()
    {
        super.init()
        
        let filter = BusMainEvents.gi.br_current_filter_data.value
        
        br_min_max.accept((filter.price_min,filter.price_max))
        br_rating.accept(filter.rating)
        br_cafe_type.accept(filter.type_cafe)
    }
}

//MARK: - Listeners
extension VmFilter
{
    func priceSliderChanged(min:Int,max:Int)
    {
        self.br_min_max.accept((min*10,max*10))
    }
    
    func clickedTypeCafe(cafe_type:TypeCafe)
    {
        br_cafe_type.accept(cafe_type)
    }
    
    func ratingChanged(rating:Double)
    {
        br_rating.accept(rating)
    }
    
    func clickedOk()
    {
        var filter_data = ModelFilterData()
        filter_data.price_min = br_min_max.value.0
        filter_data.price_max = br_min_max.value.1
        filter_data.rating = br_rating.value
        filter_data.type_cafe = br_cafe_type.value
        
        BusMainEvents.gi.br_current_filter_data.accept(filter_data)
        self.ps_dissmiss_vc.onNext(true)
    }
    
    func clickedCancel()
    {
        self.ps_dissmiss_vc.onNext(true)
    }
    
}
