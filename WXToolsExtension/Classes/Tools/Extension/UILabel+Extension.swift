//
//  UILabel+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

public extension UILabel {
    ///初始化label 字体、字体颜色 背景颜色、 字体大小、对齐方式、行数
    class func ch_label(_ text: String, _ textColor: UIColor, _ backgroundColor: UIColor, _ font: UIFont, _ textAlignment: NSTextAlignment, _ numberOfLines: Int) -> Self {
        return ch_classLabel(text, textColor, backgroundColor, font, textAlignment, numberOfLines)
    }
    ///初始化label 字体、字体颜色 字体大小、对齐方式
    class func ch_label(_ text: String, _ textColor: UIColor, _ font: UIFont, _ textAlignment: NSTextAlignment) -> Self {
        return ch_classLabel(text, textColor, font, textAlignment)
    }
}
fileprivate extension UILabel {
    
    class func ch_classLabel(_ text: String, _ textColor: UIColor, _ backgroundColor: UIColor, _ font: UIFont, _ textAlignment: NSTextAlignment, _ numberOfLines: Int) -> Self {
        let label = self.init()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.backgroundColor = backgroundColor
        return label
    }

    class func ch_classLabel(_ text: String, _ textColor: UIColor, _ font: UIFont, _ textAlignment: NSTextAlignment) -> Self {
        return ch_classLabel(text, textColor, .clear, font, textAlignment, 1)
    }
}
