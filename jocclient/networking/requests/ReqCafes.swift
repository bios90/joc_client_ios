import Foundation

struct ReqCafesList
{
    var lat: Double = 0
    var lon: Double = 0
    var distance: Int = 0
    var filter: ModelFilterData? = nil
    var order: TypeCafeSort = .Distance
    var sort: TypeSortDirection = .Asc
    var action_success: (([ModelCafe]) -> Void)? = nil
    

}
