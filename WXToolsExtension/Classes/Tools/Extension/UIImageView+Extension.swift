//
//  UIImageView+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
import Kingfisher
extension UIImageView {

    func kf_setImageWithURL(_ urlString: String?, placeholderImage: UIImage?) {
        if urlString?.isEmpty ?? true {
            
        } else {
            
            let base64Str = urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: base64Str!.fullImagePath)
            
        }
    }
    
    func kf_setImageWithUrlBlock(_ urlString: String?, placeholderImage: UIImage?,block:((_ img:UIImage?)->())? = nil) {
        
        
    }
    
}
