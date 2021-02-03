import Foundation

class BaseNetworker
{
    let base_vm:BaseVm
    
    init(base_vm:BaseVm)
    {
        self.base_vm = base_vm
    }
    
    func makeRegister(phone:String,push_token:String?,action_success:@escaping()->Void)
    {
        MyRequest.getReqRegister(phone: phone, push_token: push_token)
            .toObservable()
            .addMyParser(type: BaseResponse.self)
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success()
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func makeCodeConfirm(phone:String,code:String,action_success:@escaping(ModelUser)->Void)
    {
        MyRequest.getReqCodeConfirm(phone: phone, code: code)
            .toObservable()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func loadUser(action_success:@escaping(ModelUser)->Void)
    {
        MyRequest.getReqLoadUser()
            .toObservable()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func updateUser(name:String?,email:String?,avatar:String?,push_token:String?,action_success:@escaping(ModelUser)->Void)
    {
        MyRequest.getReqEditUser(name: name, email: email, push_token: push_token, image_str: avatar)
            .toObservable()
            .addMyParser(type: RespUserSingle.self)
            .addParsingFilter({ $0.user != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.user!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func getCafes(req:ReqCafesList,add_progress:Bool = false)
    {
        var observable = MyRequest.getReqLoadCafes(lat: req.lat, lon: req.lon, distance: req.distance, min_price: req.filter?.price_min, max_price: req.filter?.price_max, rating: req.filter?.rating, sort_by: req.order, sort_direction: req.sort)
            .toObservable()
            .addMyParser(type: RespCafes.self)
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
        
        if(add_progress)
        {
            observable = observable.addProgressDialog()
        }
        
        observable.subscribeMy(
            { response in
                
                let cafes = response.resp_cafes?.cafes ?? []
                req.action_success?(cafes)
        },
            { error in
                
        })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func loadCafe(cafe_id:Int,action_success:@escaping(ModelCafe)->Void)
    {
        MyRequest.getReqLoadCafeById(cafe_id: cafe_id)
            .toObservable()
            .addMyParser(type: RespCafeSingle.self)
            .addParsingFilter({ $0.cafe != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    response.cafe?.recountDistance()
                    action_success(response.cafe!)
            },
                { error in
                    
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func makeOrder(date:String, comment:String?,items:String,action_success:@escaping(Int)->Void,action_error:@escaping(Error)->Void)
    {
        MyRequest.getReqOrderCreate(date: date, comment: comment, items: items)
            .toObservable()
            .addMyParser(type: RespOrderCreation.self)
            .addParsingFilter({ $0.order_data?.id != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.order_data!.id!)
            },
                { error in
                    
                    action_error(error)
            })
            .disposed(by: base_vm.dispose_bag)
    }
    
    func makePay(order_id:Int,payment_token:String,action_success:@escaping(ModelOrderPayData)->Void,action_error:@escaping(Error)->Void)
    {
        MyRequest.getReqPayOrder(order_id: order_id, token: payment_token)
            .toObservable()
            .addMyParser(type: RespOrderPay.self)
            .addParsingFilter({ $0.pay_data != nil })
            .addProgressDialog()
            .addScreenDisabling()
            .addMyErrorChecker()
            .mainThreated()
            .subscribeMy(
                { response in
                    
                    action_success(response.pay_data!)
            },
                { error in
                    
                    action_error(error)
            })
            .disposed(by: base_vm.dispose_bag)
    }
}
