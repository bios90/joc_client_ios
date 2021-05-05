import UIKit
import RxSwift
import RxCocoa

func getStatusBarHeight() -> CGFloat
{
    let status_bar_height = UIApplication.shared.statusBarFrame.height
    print("Status bar height \(status_bar_height)")
    return status_bar_height
}

func runActionWithDelay(milliseconds:Int, action:@escaping ()->Void)->Disposable
{
    return Observable.just(1)
        .delay(.milliseconds(milliseconds), scheduler: MainScheduler.instance)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext:
            { _ in
                action()
        })
}


func runRepeatingAction(millisecnds:Int,max_times_to_repeat:Int, action:@escaping()->Void)->Disposable
{
    return Observable<Int>.interval(.milliseconds(millisecnds), scheduler: MainScheduler.instance)
        .take(max_times_to_repeat)
        .observeOn(MainScheduler.instance)
        .subscribe(onNext:
            { _ in
                action()
        })
}

func getTopViewController()->UIViewController
{
    var topController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
    while ((topController?.presentedViewController) != nil)
    {
        topController = topController?.presentedViewController
    }
    return topController!
}

func getOffsetForDialogs()->CGFloat
{
    let screen_width = UIScreen.main.bounds.width
    if screen_width < 400
    {
        return 20
    }
    else
    {
        return 40
    }
}

func listOfStringToSingle(strings:[String],separator:String = "\n")->String
{
    var message : String = ""
    
    for i in 0..<strings.count
    {
        message += strings[i]
        if(i != (strings.count-1))
        {
            message += separator
        }
    }
    
    return message
}

var globalJsonDecoder: JSONDecoder =
{
    let decoder = JSONDecoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DateManager.FORMAT_FOR_SERVER
    decoder.dateDecodingStrategy = .formatted(dateFormatter)
    return decoder
}()

var globalJsonEncoder : JSONEncoder =
{
    let encoder = JSONEncoder()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = DateManager.FORMAT_FOR_SERVER
    encoder.dateEncodingStrategy = .formatted(dateFormatter)
    return encoder
}()

func getScreenWidth()->CGFloat
{
    let width = UIScreen.main.bounds.width
    return width
}

func getScreenHeight()->CGFloat
{
    let width = UIScreen.main.bounds.height
    return width
}

func getBottomIcon(img:UIImage,title:String)->UITabBarItem
{
    let img_pair = HelperImages.getImgPairForTabs(img: img)
    let tab_icon = UITabBarItem(title: title,image: img_pair.img_normal,selectedImage: img_pair.img_selected)
    return tab_icon
}

func hasTopNotch()-> Bool
{
    if #available(iOS 11.0, tvOS 11.0, *)
    {
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
    
    return false
}

func getBottomSafeInset()->CGFloat
{
    if #available(iOS 11.0, *), hasTopNotch()
    {
        let window = UIApplication.shared.keyWindow!
        let bottomPadding = window.safeAreaInsets.bottom
        return bottomPadding
    }
    
    return CGFloat(0)
}

func getSumText(sum:Double)->NSAttributedString
{
    let sum_text = sum.formatWithPattern(format: .formatForPrice) + " р"
    let sum_word = MyStrings.sum.localized()+" : "
    
    let attr_reg = [ NSAttributedString.Key.font: MyFonts.gi.reg_m,]
    let attr_bold = [ NSAttributedString.Key.font: MyFonts.gi.bold_m]
    
    let final_text = NSMutableAttributedString()
    final_text.append(NSAttributedString(string: sum_word, attributes: attr_reg))
    final_text.append(NSAttributedString(string: sum_text, attributes: attr_bold))
    
    return final_text
}


func toJsonMy<T:Encodable>(from object:T) -> String?
{
    let jsonEncoder = JSONEncoder()
    let jsonData = try! jsonEncoder.encode(object)
    let json = String(data: jsonData, encoding: String.Encoding.utf8)
    
    return json
    
    //    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else
    //    {
    //        return nil
    //    }
    //
    //    return String(data: data, encoding: String.Encoding.utf8)
}

func arrayToJsonMy(arrayObject: [Any]) -> String?
{
    do
    {
        let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
        if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
        {
            return jsonString as String
        }
        
    }
    catch let error as NSError
    {
        print("Array convertIntoJSON - \(error.description)")
    }
    return nil
}

func openUrl(url_str:String)
{
    if let url = URL(string: url_str)
    {
        UIApplication.shared.open(url)
    }
}

