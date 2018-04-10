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
    //获取状态栏+导航栏高度
    @objc public func getHeight(_ param:NSDictionary,_ callback: WXModuleCallback?) {
        
        
        let statusheight = UIApplication.shared.statusBarFrame.size.height*UIScreen.main.scale
        let navigationheight = weexInstance.viewController.navigationController!.navigationBar.frame.size.height*UIScreen.main.scale
        
        
        let data=["barHeight":navigationheight,
                  "statusHeight":statusheight,
                  "topHeight":statusheight+navigationheight] as [String : Any]
        
        callback?(data)
    }
    //获取当前用户Token
    @objc public func getToken(_ param:NSDictionary,_ callback: WXModuleCallback?) {
        print("printLog:\(param["name"] ?? "")")
        let data=["token":"178b583ea44264c38df1e9ebe2900868"] as [String : Any]
        callback?(data)
    }
    //原生窗口挑战
    @objc public func goActivity(_ param:NSDictionary,_ callback: WXModuleCallback?) {
        print("printLog:\(param["type"] ?? "")")
        //type==1跳到订货中心页
        weexInstance.viewController.navigationController!.popToRootViewController(animated: true)
        
        let data=["result":"ok"] as [String : Any]
        callback?(data)
    }
}
