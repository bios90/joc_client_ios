import Foundation
import YPImagePicker

class ImagesGetterManager
{
    static func getGalleyCameraImage(action_success:@escaping(YPMediaPhoto)->Void,vc:UIViewController = getTopViewController())
    {
        var config = ImagesGetterManager.getConfigImage()
        config.library.mediaType = .photo
        config.screens = [.library,.photo]
        
        config.library.defaultMultipleSelection = false
        
        let picker = YPImagePicker(configuration: config)
        vc.present(picker, animated: true, completion: nil)
        picker.didFinishPicking(completion:
            { (items, is_cancelled) in
                
                picker.dismiss(animated: true, completion: nil)
                if !is_cancelled, let image = items.singlePhoto
                {
                    action_success(image)
                }
        })
    }
    
    static func getConfigImage()->YPImagePickerConfiguration
    {
        var config = YPImagePickerConfiguration()
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = true
        config.showsPhotoFilters = false
        
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = false
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        config.bottomMenuItemSelectedTextColour = MyColors.gi.red
        config.bottomMenuItemUnSelectedTextColour = MyColors.gi.gray3
        config.hidesBottomBar = true
        
        return config
    }
}
