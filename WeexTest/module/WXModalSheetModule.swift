//
//  WXModalSheetModule.swift
//  WeexTest
//
//  Created by 孙林 on 2018/4/9.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK
import UIKit
public extension WXModalSheetModule{
    @objc public func toast(_ param:NSDictionary){
        let message=param["message"] as? String
        //let duration=param["duration"] as? Float 显示时间
        MYProgressHUD.showMessage(weexInstance.viewController.view, message!)
    }
    @objc public func alert(_ param:NSDictionary,_ callback: WXModuleCallback?){
        var title = param["title"] as? String
        var message = param["message"] as? String
        var okTitle = param["okTitle"] as? String
        var cancelTitle = param["cancelTitle"] as? String
        
        if message==nil {message=""}
        if okTitle==nil {okTitle="确认"}
        
        //第一个参数是标题,第二个参数是消息内容,第三个参数就是上2张图中的样式,随便选一个.
        let alertViewController = MyAlertController(title: title, message:message, preferredStyle: .alert)
        //如果没有调用addAction方法, 对话框也是会显示的.但是没有可以点击的按钮.
        if cancelTitle != nil {
            alertViewController.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { action in
                let data=["result":2] as [String : Any]
                callback?(data)
        }))
        }
        //UIAlertAction的第二个参数是 按钮的样式(取消(粗体显示),消极(红色显示),正常)3种样式.
        //第三个参数是一个函数类型的参数. 表示点击按钮之后的调用的方法.
        alertViewController.addAction(UIAlertAction(title: okTitle, style: .default, handler: { action in
            let data=["result":1] as [String : Any]
            callback?(data)
        })
        )
        //显示对话框
        weexInstance.viewController.navigationController?.present(alertViewController, animated: true, completion: {})
    }
}
