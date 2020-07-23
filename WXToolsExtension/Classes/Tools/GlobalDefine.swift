//
//  GlobalDefine.swift
//  DoctorProject
//
//  Created by Ly on 2020/7/20.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
import Foundation


public let kIsIphoneX = iphoneX_Series
public let kBottomHeight: CGFloat = iphoneX_Series ? 34.0 : 0.0
public let kNavgationAllH:CGFloat = iphoneX_Series ? 88 : 64
public let kTabbarHeight:CGFloat = 49
public let kBottomAllHeight = kBottomHeight + kTabbarHeight
public let kStatusHeight:CGFloat = kNavgationAllH - 44

public var kAppCodeTimeCount: Int {
    #if DEBUG
    return 5
    #else
    return 60
    #endif
}

var screenWidth: CGFloat {
    get {
        return UIScreen.main.bounds.size.width
    }
}

var screenHeight: CGFloat {
    get {
        return UIScreen.main.bounds.size.height
    }
}

var statusBarHeight:CGFloat{
    get {
        return UIApplication.shared.statusBarFrame.size.height
    }
}

var navBarHeight:CGFloat{
    get {
        return 44.0
    }
}

var navTopHeight:CGFloat{
    get {
        return navBarHeight + statusBarHeight
    }
}

@available(iOS 11.0, *)
var unSafeBottomHeight :CGFloat{
    get {
        if iphoneX_Series{
            return  WINDOW!.safeAreaInsets.bottom
        }
        else{
            return 0
        }
    }
}
var safeBottomHeight :CGFloat{
    get {
        if #available(iOS 11.0, *) {
            let top = WINDOW?.safeAreaInsets.top
            let bottom = WINDOW?.safeAreaInsets.bottom
            return  UIScreen.main.bounds.size.height - top! - bottom!
        }
        else{
            return  UIScreen.main.bounds.size.height
        }
    }
}

//2. iPhoneX系列
var iphoneX_Series: Bool {
    get {
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone{
            debugPrint("不是iPhone， 是 \(UIDevice.current.userInterfaceIdiom.rawValue)")
        }
        if #available(iOS 11.0, *) {
            if let bottom = WINDOW?.safeAreaInsets.bottom , bottom > 0 {
                return true
            }
        }
        else{
            debugPrint("iOS11 之前的版本")
        }
        return false
    }
}

func scale(width: CGFloat) -> CGFloat {
    return width * screenWidth / 375
}

func scale(height: CGFloat) -> CGFloat {
    return height * screenHeight / 667
}

