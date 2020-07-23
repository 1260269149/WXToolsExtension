//
//  UIColor+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {


    convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    ///十六进制字符串形式颜色值
    class func ch_color(_ hex: String) -> UIColor {
        return hexString(hex)
    }
    
    static var ch_randomColor: UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    ///适配暗黑模式设置颜色 dark -- 暗黑模式下的颜色   light -- 其他模式下的颜色
    class func ch_traitColor(_ dark:UIColor = .white, _ light:UIColor) -> UIColor {
       if #available(iOS 13.0, *) {
           let color = UIColor{ (traitCollection) -> UIColor in
               if traitCollection.userInterfaceStyle == .dark {
                   return dark
               } else {
                   return light
               }
           }
           return color
       } else {
           return light
       }
    }
    
    
    /// 根据十六进制文字创建颜色
    class  func hexString(_ hexString:String,_ alpha:CGFloat = 1 ) -> UIColor {
        //处理数值
        var cString = hexString.uppercased().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let length = (cString as NSString).length
        if (length < 6 || length > 7 || (!cString.hasPrefix("#") && length == 7)){//错误处理
            return UIColor.white
        }
        if cString.hasPrefix("#"){
            cString = (cString as NSString).substring(from: 1)
        }
        //字符串截取
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        var r:UInt32 = 0,g:UInt32 = 0,b:UInt32 = 0 //存储转换后的数值
        //进行转换
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        //根据颜色值创建UIColor
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }

    class func `for`(light: UIColor, dark: UIColor? = nil) -> UIColor {
        if #available(iOS 13.0, *) {
            if dark == nil {
                var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
                light.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
                return UIColor(dynamicProvider: { $0.userInterfaceStyle == .light ? light : UIColor(red: 1 - red, green: 1 - green, blue: 1 - blue, alpha: alpha) })
            } else {
                return UIColor(dynamicProvider: { $0.userInterfaceStyle == .light ? light : dark! })
            }
        } else {
            return light
        }
    }
    
    class var random: UIColor {
        get {
            return UIColor(UInt(arc4random() % 0xffffff))
        }
    }
    
    class var separatorColor: UIColor {
        return UIColor(white: 0, alpha: 0.2)
    }
    
    class var systemBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    static var tableGroupedBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.systemGroupedBackground
        } else {
            return #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        }
    }
    
    class var tableCellGroupedBackgroundColor: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.value(forKey: "tableCellGroupedBackgroundColor") as! UIColor
        }
        return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
