//
//  WXTitleBarModule.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/23.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK

public extension WXTitleBarModule {
    @objc public func push(_ param:NSDictionary,_ callback: WXModuleCallback?){
        //print("url:\(param["url"] ?? "")")//
        //print("title:\(param["title"] ?? "")")//
        //print("animated:\(param["animated"] ?? "")")//
        var animated=param["animated"] as? Bool
        if animated == nil {
            animated=true
        }
        let vc=ViewController()
        vc.setUrl(url: param["url"] as! String)
        vc.hidesBottomBarWhenPushed=true
        vc.navigationItem.title=param["title"] as? String
        
        
        //右侧按钮
        let rTitle=param["rTitle"] as? String
        let rColor=param["rColor"] as? String
        let rTag=param["rTag"] as? Int
        let rImg=param["rImg"] as? String
        vc.setRightItem(title:rTitle, color: rColor, tag: rTag, img: rImg)
        weexInstance.viewController.navigationController?.pushViewController(vc, animated: animated!)
    }
    
    @objc public func setNavBarRightItem(_ param:NSDictionary,_ callback: WXModuleCallback?){
        print("title:\(param["title"] ?? "")")//1=TXT,2=img
        print("color:\(param["titleColor"] ?? "")")//1=TXT,2=img
        print("tag:\(param["tag"] ?? "")")//1=TXT,2=img
        print("img:\(param["img"] ?? "")")//1=TXT,2=img
        
        //右侧按钮
        let title=param["title"] as? String
        let color=param["color"] as? String
        let tag=param["tag"] as? Int
        let img=param["img"] as? String
        
        setRightItem(vc:weexInstance.viewController,title: title, color: color, tag: tag, img: img)

        let data=["result":"ok"] as [String : Any]
        callback?(data)
    }
    func setRightItem(vc:UIViewController,title:String?,color:String?,tag:Int?,img:String?){
        if title==nil && img==nil {return}
        if img == nil {
            let button1 = UIButton(type: .system)
            button1.setTitle(title, for: UIControlState.normal)
            button1.tag=(tag ?? 0)
            //button1.titleLabel?.font = UIFont.systemFontOfSize(17)
            button1.addTarget(self,action:#selector(onclick(_:)),for:.touchUpInside)
            if color != nil {
                button1.setTitleColor(SWColor(hexString: color!), for: UIControlState.normal)
            }
            let barButton1 = UIBarButtonItem(customView: button1)
            weexInstance.viewController.navigationItem.rightBarButtonItems=[barButton1]
        }else{
            let button1 = UIButton(frame:CGRect(x: 0, y: 0, width: 18, height: 18))
            button1.setBackgroundImage(UIImage(named: img!), for: UIControlState.normal)
            button1.isHighlighted=false
            button1.tag=(tag ?? 0)
            //button1.titleLabel?.font = UIFont.sy/Users/sunlin/web/weex/incubator-weex/ios/playground/WeexDemo/UIViewController+WXDemoNaviBar.mstemFontOfSize(17)
            button1.addTarget(self,action:#selector(onclick(_:)),for:.touchUpInside)
            let barButton1 = UIBarButtonItem(customView: button1)
            vc.navigationItem.rightBarButtonItems=[barButton1]
        }
    }
    @objc func onclick(_ obj:UIButton){
        WXSDKManager.bridgeMgr().fireEvent(weexInstance?.instanceId, ref: WX_SDK_ROOT_REF, type: "navclick", params: ["tag":obj.tag], domChanges: nil)
    }
    @objc public func pop(_ param:NSDictionary){
        var animated=param["animated"] as? Bool
        if animated == nil {
            animated=true
        }
        weexInstance.viewController.navigationController?.popViewController(animated: animated!)
    }
}
