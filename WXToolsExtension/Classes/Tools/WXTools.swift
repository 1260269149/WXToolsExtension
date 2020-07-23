//
//  WXTools.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit

class WXTools: NSObject {

    class func br_afterTimeRunAction( cancleBlock: (()->())?,time:TimeInterval = 1)  {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            cancleBlock?()
        }
    }
    
}
