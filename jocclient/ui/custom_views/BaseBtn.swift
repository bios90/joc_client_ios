import UIKit
import RxSwift
import RxCocoa
import SnapKit

class BaseBtn:UIButton
{
    let dispose_bag = DisposeBag()
    
    var br_text:BehaviorRelay<String> = BehaviorRelay(value:"")
    var br_text_color:BehaviorRelay<UIColor> = BehaviorRelay(value: MyColors.gi.red)
    var br_font:BehaviorRelay<UIFont> = BehaviorRelay(value: MyFonts.gi.reg_m)
    
    var my_btn:UIImageView?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        self.contentEdgeInsets = UIEdgeInsets(top: 0,left: 12,bottom: 0,right: 12)
        
        self.br_text
            .asObservable()
            .map { $0 }
            .bind(to:self.rx.title(for: .normal))
            .disposed(by:self.dispose_bag)
        
        self.br_text_color
            .asObservable()
            .subscribe(onNext:
                { color in
                    self.setTitleColor(color, for: .normal)
                    self.setTitleColor(.green, for: .selected)
            }).disposed(by:self.dispose_bag)
        
        self.br_font
            .distinctUntilChanged()
            .subscribe(onNext:
                { font in
                    
                    self.titleLabel!.font = font
            }).disposed(by: dispose_bag)
    }
    
    func addImage(image:UIImage,size:Int)
    {
        my_btn?.removeFromSuperview()
        my_btn = UIImageView(image: image)
        self.addSubview(my_btn!)
        br_text.accept("")
        
        my_btn?.snp.makeConstraints(
            { make in
                
                make.center.equalToSuperview()
                make.width.height.equalTo(size)
        })
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
