import UIKit

class LaDialogUniversal:UIView
{
    static let subviews_side_padding = 16
    static let btn_height = 34
    
    let la_dialog: UIView =
    {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let scroll_view :UIScrollView =
    {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let stack_for_all : UIStackView =
    {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    let lbl_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.bold_l
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_sub_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_s
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let view_divider_1:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let tf_text:BaseTextField =
    {
        let tf = ViewsHelper.getGrayTf()
        return tf
    }()
    
    let view_divider_2:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let view_for_btns:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let btn_ok:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = .clear
        btn.br_text_color.accept(MyColors.gi.red)
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        return btn
    }()
    
    let btn_cancel:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text_color.accept(MyColors.gi.red)
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        return btn
    }()
    
    let btn_left:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text_color.accept(MyColors.gi.red)
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        return btn
    }()
    
    private var builder:BuilderDialogMy
    
    init(builder:BuilderDialogMy)
    {
        self.builder = builder
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
        let offset_side = getOffsetForDialogs()
        let views_max_width = CGFloat(UIScreen.main.bounds.width) - CGFloat(offset_side * 2) - CGFloat(LaDialogUniversal.subviews_side_padding * 2)
        
        self.addSubview(la_dialog)
        if(builder.is_in_scroll_mode)
        {
            self.la_dialog.addSubview(scroll_view)
            self.scroll_view.addSubview(stack_for_all)
            scroll_view.snp.makeConstraints(
                { make in
                    
                    make.edges.equalToSuperview()
            })
            
        }
        else
        {
            self.la_dialog.addSubview(stack_for_all)
        }
        
        stack_for_all.snp.makeConstraints(
            { make in
                
                make.width.equalTo(views_max_width)
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(LaDialogUniversal.subviews_side_padding)
                
        })
        
        
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.width.equalTo(views_max_width)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.width.equalTo(views_max_width)
        })
        
        tf_text.snp.makeConstraints(
            { make in
                
                make.width.equalTo(views_max_width)
                make.height.equalTo(34)
        })
        
        
        la_dialog.snp.makeConstraints(
            { make in
                
                
                make.left.equalToSuperview().offset(offset_side)
                make.right.equalToSuperview().offset(-offset_side)
                if(builder.is_in_scroll_mode == false)
                {
                    make.center.equalToSuperview()
                    make.top.equalTo(stack_for_all.snp.top)
                    make.bottom.equalTo(stack_for_all.snp.bottom).offset(LaDialogUniversal.subviews_side_padding)
                }
                else
                {
                    make.top.equalToSuperview().offset(offset_side)
                    make.bottom.equalToSuperview().offset(-offset_side)
                }
                
        })
        
        
        if(builder.title != nil)
        {
            stack_for_all.addArrangedSubview(lbl_title)
            lbl_title.text = builder.title
        }
        
        if(builder.text != nil)
        {
            stack_for_all.addArrangedSubview(lbl_sub_title)
            if builder.is_html_text
            {
                lbl_sub_title.attributedText = builder.text!.htmlToAttributedString
            }
            else
            {
                lbl_sub_title.text = builder.text
            }
        }
        
        if(builder.with_tf)
        {
            view_divider_1.snp.makeConstraints(
                { make in
                    
                    make.height.equalTo(10)
            })
            stack_for_all.addArrangedSubview(view_divider_1)
            stack_for_all.addArrangedSubview(tf_text)
        }
        
        view_for_btns.snp.makeConstraints(
            { make in
                
                make.height.equalTo(LaDialogUniversal.btn_height)
                make.width.equalTo(views_max_width)
        })
        
        view_divider_2.snp.makeConstraints(
            { make in
                
                make.height.equalTo(10)
        })
        
        stack_for_all.addArrangedSubview(view_divider_2)
        stack_for_all.addArrangedSubview(view_for_btns)
        
        if let btn_ok_action = builder.btn_ok
        {
            view_for_btns.addSubview(btn_ok)
            btn_ok.snp.makeConstraints(
                { make in
                    
                    make.height.equalTo(LaDialogUniversal.btn_height)
                    make.right.equalToSuperview()
            })
            
            btn_ok.br_text.accept(btn_ok_action.text)
            btn_ok.addAction {
                
                self.clickedOk()
            }
        }
        
        if let btn_cancel_action = builder.btn_cancel
        {
            btn_cancel.br_text.accept(btn_cancel_action.text)
            btn_cancel.addAction {
                self.clickedCancel()
            }
            
            view_for_btns.addSubview(btn_cancel)
            btn_cancel.snp.makeConstraints(
                { make in
                    
                    make.height.equalTo(LaDialogUniversal.btn_height)
                    make.right.equalTo(btn_ok.snp.left)
            })
        }
        
        if let btn_left_action = builder.btn_left
        {
            btn_left.br_text.accept(btn_left_action.text)
            btn_left.addAction {
                self.clickedLeft()
            }
            
            view_for_btns.addSubview(btn_left)
            btn_left.snp.makeConstraints(
                { make in
                    
                    make.height.equalTo(LaDialogUniversal.btn_height)
                    make.left.equalToSuperview()
            })
        }
        
        scroll_view.resizeContentToFit(offset: CGFloat(LaDialogUniversal.subviews_side_padding))
    }
    
    private func clickedOk()
    {
        MessagesManager.dismissDialogWithName(name: builder.dialog_name)
        let text = tf_text.text.getNullable()
        builder.btn_ok?.action(text as AnyObject?)
    }
    
    private func clickedCancel()
    {
        MessagesManager.dismissDialogWithName(name: builder.dialog_name)
        let text = tf_text.text.getNullable()
        builder.btn_cancel?.action(text as AnyObject?)
    }
    
    private func clickedLeft()
    {
        MessagesManager.dismissDialogWithName(name: builder.dialog_name)
        let text = tf_text.text.getNullable()
        builder.btn_left?.action(text as AnyObject?)
    }
    
}
