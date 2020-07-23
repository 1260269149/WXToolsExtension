//
//  Number+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

extension NSNumber{
    var date: Date?{
        if self == 0{
            return nil
        }else{
            return Date(timeIntervalSince1970: TimeInterval(self.int64Value))
        }
    }
}
