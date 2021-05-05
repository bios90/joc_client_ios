import Foundation
import MultiSlider

class ViewFilter:BaseViewController
{
    var vm_filter:VmFilter!
    var factory_filter:FactoryFilter!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_filter)
        factory_filter = FactoryFilter(vc: self)
        
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_filter.br_min_max
            .subscribe(onNext:
                { values in
                    
                    self.factory_filter.lbl_price_min.text = "\(values.0)"
                    self.factory_filter.lbl_price_max.text = "\(values.1)"
                    
                    let view_min = Int(self.factory_filter.range_bar.value[0])
                    let view_max = Int(self.factory_filter.range_bar.value[1])
                    
                    if view_min != Int(values.0 / 10) || view_max != Int(values.1 / 10)
                    {
                        self.factory_filter.range_bar.value = [CGFloat(values.0 / 10),CGFloat(values.1 / 10)]
                    }
            })
            .disposed(by: dispose_bag)
        
        vm_filter.br_cafe_type
            .subscribe(onNext:
                { cafe_type in
                    
                    if cafe_type.getPos() != self.factory_filter.bubbles_cafe_type.getSelected()
                    {
                        self.factory_filter.bubbles_cafe_type.setSelected(selected:[cafe_type.getPos()])
                    }
            })
            .disposed(by: dispose_bag)
        
        vm_filter.br_rating
            .subscribe(onNext:
                { rating in
                    
                    let text = rating.formatWithPattern(format: .formatForRating)
                    self.factory_filter.lbl_rating_num.text = text
                    
                    if self.factory_filter.rating_view.rating != rating
                    {
                        self.factory_filter.rating_view.rating = rating
                    }
            })
        .disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_filter.range_bar.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
        factory_filter.bubbles_cafe_type.my_listener = {
            poses in
            guard let pos = self.factory_filter.bubbles_cafe_type.getSelected() else { return }
            let type = TypeCafe.initFromPos(pos: pos)
            self.vm_filter.br_cafe_type.accept(type)
        }
        
//        factory_filter.bubbles_cafe_type.bubbles[0].addAction {
//            self.vm_filter.clickedTypeCafe(cafe_type: .All)
//        }
//        
//        factory_filter.bubbles_cafe_type.bubbles[1].addAction {
//            self.vm_filter.clickedTypeCafe(cafe_type: .Cafe)
//        }
//        
//        factory_filter.bubbles_cafe_type.bubbles[2].addAction {
//            self.vm_filter.clickedTypeCafe(cafe_type: .CoffeeSpot)
//        }
        
        factory_filter.rating_view.didTouchCosmos =
            { rating in
                
                self.vm_filter.ratingChanged(rating: rating)
        }
        
        factory_filter.btn_ok.addAction {
            self.vm_filter.clickedOk()
        }
        
        factory_filter.btn_cancel.addAction {
            self.vm_filter.clickedCancel()
        }
    }
    
    @objc func sliderChanged(slider: MultiSlider)
    {
        let min = Int( slider.value[0])
        let max = Int( slider.value[1])
        
        vm_filter.priceSliderChanged(min: min, max: max)
    }
    
    
    
}
