//
//  SharedData.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/24.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
class SharedData {
    public static func saveValue(value:String,key:String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    public static func getValue(key:String)->String?{
        return UserDefaults.standard.string(forKey: key)
    }
}
