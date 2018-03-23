//
//  WXURLRewrite.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/16.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK
class WXURLRewrite: NSObject, WXURLRewriteProtocol{
    func rewriteURL(_ url: String!, with resourceType: WXResourceType, with instance: WXSDKInstance!) -> URL! {
        let completeURL=URL(string: url)
        if (completeURL?.isFileURL)! {
            return completeURL
        }else if (completeURL?.scheme?.lowercased() == "local"){
            return completeURL
        }else{
            return instance.completeURL(url)
        }
    }
}
