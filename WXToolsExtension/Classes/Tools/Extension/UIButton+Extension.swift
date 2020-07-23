//
//  UIButton+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

public extension UIButton {

    func kf_setImageWithURL(_ urlString: String?, placeholderImage: UIImage?) {
        if urlString?.isEmpty ?? true {
            setImage(placeholderImage, for: .normal)
        } else {
            let url = URL(string: urlString!.fullImagePath)
            kf.setImage(with: url, for: .normal, placeholder: placeholderImage, options: nil, progressBlock: nil) { (img, err, type, url) in
                
            }
        }
    }
    
    func kf_setBgImageWithURL(_ urlString: String?, placeholderImage: UIImage?) {
        if urlString?.isEmpty ?? true {
            self.setBackgroundImage(placeholderImage, for: .normal)
        } else {
            let url = URL(string: urlString!.fullImagePath)
            kf.setImage(with: url, for: .normal, placeholder: placeholderImage, options: nil, progressBlock: nil) { (img, err, type, url) in
                
            }
        }
    }
    
    
    
    
    ////初始化button  设置 标题文字、文字颜色、文字大小
    class func ch_button(_ title:String, _ titleColor:UIColor, _ backgroundColor: UIColor, _ font:UIFont, _ target:Any, _ action:Selector) -> Self {
        return ch_base_button(title, titleColor, backgroundColor, font, target, action)
    }
    
    ////初始化button  设置 标题文字、文字颜色、文字大小
    class func ch_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ target:Any, _ action:Selector) -> Self {
        return ch_base_button(title, titleColor, font, target, action)
    }
}

fileprivate extension UIButton {
    
    ////初始化button  设置 标题文字、文字颜色、文字大小
    class func ch_base_button(_ title:String, _ titleColor:UIColor, _ backgroundColor: UIColor, _ font:UIFont, _ target:Any, _ action:Selector) -> Self {
        let button = self.init(type: .custom)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        button.addTarget(target, action:action, for: .touchUpInside)
        return button
    }
    
    ////初始化button  设置 标题文字、文字颜色、文字大小
    class func ch_base_button(_ title:String, _ titleColor:UIColor, _ font:UIFont, _ target:Any, _ action:Selector) -> Self {
        return ch_base_button(title, titleColor, .clear, font, target, action)
    }

}
