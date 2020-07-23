//
//  String+Extension.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import Foundation
import UIKit

extension String {

    //转CGFloat
    func floatValue() -> CGFloat{
        var cgFloat:CGFloat = 0
        if let doubleValue = Double(self){
            cgFloat = CGFloat(doubleValue)
        }
        return cgFloat
    }
    func toImage() -> UIImage? {
        return UIImage(named: self)
    }
    var toColor:UIColor? {
        return UIColor.init(self, alpha: 1)
    }
    func toNoti() -> NSNotification.Name {
        let noti = NSNotification.Name.init(self)
        return noti
    }
    func br_isTelNumber() -> Bool {
        let tel = "1[0-9]([0-9]){9}"
        let regexTel = NSPredicate(format: "SELF MATCHES %@",tel)
        return regexTel.evaluate(with: self)
        
    }
    func toRequired(defaultStr: String) -> String{
        if self.count > 0 {
           return self
        }
        return defaultStr
    }
    // 图片的全路径
    var fullImagePath: String {
        if self.isEmpty {
            return self
        } else {
            if self.hasPrefix("http://") || self.hasPrefix("https://") {
                return self
            } else {
                return baseUrl + self
            }
        }
    }
    
    
    func ga_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
            let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            return ceil(rect.height)
    }
    func ga_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    func ga_heightWithBoldForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
            let font = UIFont.boldSystemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            return ceil(rect.height)
    }
    func ga_widthWithBoldForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
}

extension NSMutableAttributedString{
    
    //MARK: 选中字体颜色变红
    /// - Parameters:
    ///   - text: 所有字符串
    ///   - selectedText: 需要变颜色的字符串
    ///   - allColor: 字符串本来颜色
    ///   - selectedColor: 选中字符串颜色
    ///   - fone: 字符串字体大小
    ///     fone: 选中字符串字体大小
    /// - Returns: 返回一个NSMutableAttributedString
    static func attributenStringColor(text:String,
                                 selectedText: String,
                                 allColor: UIColor,
                                 selectedColor: UIColor,
                                 font: UIFont,
                                 selectedFont:UIFont)->NSMutableAttributedString{
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font :  font,NSAttributedString.Key.foregroundColor:allColor])
        var text = text as NSString
        
        while text.contains(selectedText) {
            let rang: NSRange =  text.range(of: selectedText)
            let rang2 = NSMakeRange(rang.location + lastLength, rang.length)
            rangeArray.append(rang2)
            lastLength += (rang.length + rang.location )
            text = text.substring(from: rang.length + rang.location) as NSString
        }
        
        for range1 in rangeArray {
            attStr.setAttributes([NSAttributedString.Key.foregroundColor:selectedColor,NSMutableAttributedString.Key.font: selectedFont], range: range1)
        }
        
        return attStr
    }
    
    
    //MARK: 指定两个字符中间文字变色
    ///
    /// - Parameters:
    ///   - text: 所有字符串
    ///   - allColor: 基础颜色
    ///   - selectedColor: 特殊颜色
    ///   - firstStr: 其实字符串
    ///   - lastStr: 结束字符串
    ///   - fone: 基础字体
    /// - Returns: NSMutableAttributedString
    static func attributenStringMutColor(text:String,
                                 allColor: UIColor,
                                 selectedColor: UIColor,
                                 firstStr : String,
                                 lastStr : String,
                                 fone: CGFloat)->NSMutableAttributedString{
        
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fone),NSAttributedString.Key.foregroundColor:allColor])
        var text = text as NSString
        
        while text.contains(firstStr) {
            let rang1: NSRange =  text.range(of: firstStr)
            let range2: NSRange =  text.range(of: lastStr)
            let orangeRange = NSMakeRange(rang1.location + 1, range2.location - (rang1.location + 1))
            let range = NSMakeRange(rang1.location + 1 + lastLength , range2.location - (rang1.location + 1) )
            rangeArray.append(range)
            lastLength += (orangeRange.length + orangeRange.location + 1)
            text = text.substring(from: orangeRange.length + orangeRange.location + 1) as NSString
        }
        
        for range1 in rangeArray {
            attStr.setAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], range: range1)
        }
        
        return attStr
    }
    
    
    //MARK: 行间距
    ///
    /// - Parameters:
    ///   - text: 整体字符串
    ///   - lineSpace: 行间距
    ///   - fone: 字图
    /// - Returns: NSMutableAttributedString
    static func lineSpace(text: String,lineSpace: CGFloat,fone: CGFloat)->NSMutableAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fone)])
        attStr.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSMakeRange(0, text.count))
        
        return attStr
    }
    
    
    /// 可变字体
    ///
    /// - Parameters:
    ///   - text: 整体字符串
    ///   - selectedText: 选中字符串
    ///   - allFont: 基础字体
    ///   - selectedFont: 变化字体
    ///   - textColor: 字符串颜色
    /// - Returns: NSMutableAttributedString
    static func attributenStringFont(text:String,
                                      selectedText: String,
                                      allFont: CGFloat,
                                      selectedFont: CGFloat,
                                      textColor: UIColor)->NSMutableAttributedString{
        var rangeArray: [NSRange] = [NSRange]()
        var lastLength: Int = 0
        let attStr = NSMutableAttributedString.init(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: allFont),NSAttributedString.Key.foregroundColor:textColor])
        var text = text as NSString
        
        while text.contains(selectedText) {
            let rang: NSRange =  text.range(of: selectedText)
            let rang2 = NSMakeRange(rang.location + lastLength, rang.length)
            rangeArray.append(rang2)
            lastLength += (rang.length + rang.location )
            text = text.substring(from: rang.length + rang.location) as NSString
        }

        for range1 in rangeArray {
            //NSForegroundColorAttributeName:UIColor.red 去掉后就没特殊颜色了
            attStr.setAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: selectedFont),NSAttributedString.Key.foregroundColor:UIColor.red], range: range1)
        }
    
        return attStr
    }
}

