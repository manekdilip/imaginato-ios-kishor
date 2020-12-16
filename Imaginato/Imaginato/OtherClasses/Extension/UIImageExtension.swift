//
//  UIImageViewExtension.swift


import UIKit

extension UIImageView {
    func changeImageColor(color:UIColor) -> UIImage{
        image = image!.withRenderingMode(.alwaysTemplate)
        tintColor = color
        return image!
    }
    
    
}





