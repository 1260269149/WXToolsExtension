//
//  NSObject+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
extension NSObject{
     
     class func br_IQManagerEidt(isEdit:Bool) {
         IQKeyboardManager.shared.enable = isEdit
         IQKeyboardManager.shared.enableAutoToolbar = isEdit
     }
    
    
    
}
