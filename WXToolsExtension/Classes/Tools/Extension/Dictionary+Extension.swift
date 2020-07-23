//
//  Dictionary+Extension.swift
//  DoctorProject
//
//  Created by wangxu on 2020/7/23.
//  Copyright © 2020 Ly. All rights reserved.
//

import UIKit
extension Dictionary{
    func toString() -> String? {
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: self, options: .init(rawValue: 0))
        } catch (let error) {
            print(error)
        }
        guard data != nil else { return nil }
        return String(data: data!, encoding: .utf8)
    }
}
