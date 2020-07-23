//
//  Date+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

extension Date{
    var calendar: Calendar {
        return Calendar.current
    }
    
    static func dateFromString(_ dateString: String?, withFormat format: String) -> Date? {
        if dateString == nil {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString!)
    }
        
    static var dateFormatter:DateFormatter?

    // MARK: - Conversion
    func toStringWithFormat(_ format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        if Date.dateFormatter == nil {
            Date.dateFormatter = DateFormatter()
        }
        let dateFormatter = Date.dateFormatter
        if let dateFormatter = dateFormatter  {
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: self)
        }
        return "\(Int(self.timeIntervalSince1970))"
       
    }
    
    var dateTimeyyyy_MM_dd_HH_mm_ss: String {
        return toStringWithFormat("yyyy-MM-dd HH:mm:ss")
    }
    var dateTimeyyyyMMddHHmmss: String {
        return toStringWithFormat("yyyyMMddHHmmss")
    }
    var dateTimeyyyy_MM_dd: String{
        return toStringWithFormat("yyyy-MM-dd")
    }
}
