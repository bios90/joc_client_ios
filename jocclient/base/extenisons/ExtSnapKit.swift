import SnapKit

extension ConstraintMakerExtendable
{
    func equalToTopWithSafe(parent:UIView,offset:Double)->ConstraintMakerExtendable
    {
        if #available(iOS 11, *)
        {
        self.top.equalTo(parent.safeAreaLayoutGuide.snp.topMargin).offset(offset)
        }
        else
        {
            self.top.equalToSuperview().offset(offset)
        }
        
        return self
    }
    
    func equalToBottomWithSafe(parent:UIView,offset:Double)->ConstraintMakerExtendable
    {
        if #available(iOS 11, *)
        {
        self.bottom.equalTo(parent.safeAreaLayoutGuide.snp.bottomMargin).offset(offset)
        }
        else
        {
            self.bottom.equalToSuperview().offset(offset)
        }
        
        return self
    }
}
