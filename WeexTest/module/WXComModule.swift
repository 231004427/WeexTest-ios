//
//  WXSwiftTestModule.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/3.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK

public extension WXComModule {
    @objc public func printLog(_ msg:NSDictionary,_ callback: WXModuleCallback?) {
        print("printLog:\(msg["name"] ?? "")")
        let data=["device":"hello","id":123] as [String : Any]
       callback?(data)
    }
    @objc public func reload() {
        let vc=weexInstance.viewController as! ViewController
        vc.reload()
    }
}
