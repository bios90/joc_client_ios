import UIKit
import NVActivityIndicatorView

class LaProgress:UIView
{
    let progress : NVActivityIndicatorView =
    {
        let activityIndicatorView = NVActivityIndicatorView(frame: .zero,type: .ballSpinFadeLoader,color: MyColors.gi.white)
        return activityIndicatorView
    }()
    
    let lbl:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.font = MyFonts.gi.reg_m
        lbl.text = MyStrings.loading.localized()
        return lbl
    }()
    
    init()
    {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.backgroundColor = MyColors.gi.gray8.withAlphaComponent(0.7)
        self.addSubview(progress)
        self.addSubview(lbl)
      
    
        progress.snp.makeConstraints(
            { make in
                
                make.center.equalToSuperview()
                make.width.height.equalTo(50)
        })
        progress.startAnimating()

        lbl.snp.makeConstraints(
            { make in
                
                make.top.equalTo(progress.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
        })
    }
}
