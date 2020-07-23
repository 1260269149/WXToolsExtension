//
//  Double+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
extension Double{
    // 两位小数
    var string2decimal: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return (formatter.string(from: NSNumber(value: self)) ?? "").replacingOccurrences(of: ",", with: "")
    }
    
    func stringDecimal(digit:Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digit
        return (formatter.string(from: NSNumber(value: self)) ?? "").replacingOccurrences(of: ",", with: "")
    }
}
extension CGFloat{
    // 两位小数
       var string2decimal: String {
           let formatter = NumberFormatter()
           formatter.numberStyle = .decimal
           formatter.maximumFractionDigits = 2
           return (formatter.string(from: NSNumber(value: Float(self))) ?? "").replacingOccurrences(of: ",", with: "")
       }
}
extension Int{
    var toNumberStr:String{
        
        var result = ""
        if self/10000 > 0 {
            result = "\(self/10000)" + "w+"
        }
        else if self/1000 > 0 {
            result = "\(self/1000)" + "k+"

        }else {
            result = "\(self)"
        }
        return result
    }
}
