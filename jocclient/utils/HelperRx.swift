import UIKit
import RxSwift
import RxCocoa

infix operator <->
func <->(textField:UITextField,br:BehaviorRelay<String?>) -> Disposable
{
    let disposeTfToBr =  textField.rx.controlEvent(.editingChanged)
        .asObservable()
        .subscribe(onNext:
            {
                text in
                let text_current = textField.text.getNullable()
                if(br.value != text_current)
                {
                    br.accept(text_current)
                }
        })
    
    let disposeBrToText = br.subscribe(onNext:
    { text in
        
        if(text != textField.text)
        {
            textField.text = text
        }
    })
    
    return Disposables.create(disposeTfToBr,disposeBrToText)
}
