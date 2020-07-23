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
    
    class func br_runMain( block: (()->())?) {
        DispatchQueue.main.async {
            block?()
        }
    }
    
    /// 判断是否是 iphonex 系列
    class  func br_isIphoneFullScreen() -> Bool {
        
        if screenWidth == 812.0 || screenHeight == 896.0 {
            return true
        }
        if #available(iOS 11.0, *) {
            if (UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 ) > 0 {
                return true
            }
        }
        return false
    }
    
    class func getTabbar() -> UITabBarController? {
        let tabbar = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
        return tabbar
    }
    
//    class func toTabbar() {
//
//        let prense = self.getTabbar()?.presentedViewController
//        if prense == nil {
//            let app = UIApplication.shared.delegate as? AppDelegate
//            app?.toTabbar()
//        }else {
//            prense?.dismiss(animated: true, completion: nil)
//        }
//    }
    
    class func getPhoneCode(sender: UIButton, phone: String?){
        guard phone?.trimmingCharacters(in: .whitespaces).br_isTelNumber() ?? true else {
//            MBProgressHUDSwift.showInfo("请输入正确的手机号", nil)
            
            return
        }
        var timer: Timer?
        var count = kAppCodeTimeCount
        var str = ""
       
//       let viewModel = BRLogInViewModel()
//        viewModel.mCompleteStatusHandler = {(end,rsp,error) in
//            
//            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
//                count = count - 1
//                if count <= 0{
//                    str = "重新发送"
//                    sender.isEnabled = true
//                    t.invalidate()
//                }else{
//                    str = "\(count)s"
//                    sender.isEnabled = false
//                }
//                sender.setTitle(str, for: .normal)
//            }
//        }
//        viewModel.getCode(mobile: phone, event: event)
    }
}
