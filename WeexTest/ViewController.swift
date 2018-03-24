//
//  ViewController.swift
//  WeexTest
//
//  Created by 孙林 on 2018/2/28.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import UIKit
import WeexSDK
class ViewController: UIViewController {
    var instance:WXSDKInstance?
    var weexView = UIView()
    var weexHeight:CGFloat?
    var top:CGFloat?
    var url="http://127.0.0.1:8081/dist/index.weex.js"
    var rTitle:String?
    var rColor:String?
    var rTag:Int?
    var rImg:String?
    var isGet=true
    var isLoading=false;
   let restConn=RestConn()
    var weexJSVesion:WeexJSVesion!
    var path="/weex/js"
    var filePath=""
    
    public func setRightItem(title:String?=nil,color:String?="",tag:Int?=0,img:String?=nil){
        rTitle=title
        rColor=color
        rTag=tag
        rImg=img
    }
    func buildRightItem(title:String?,color:String?,tag:Int?,img:String?){
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
            navigationItem.rightBarButtonItems=[barButton1]
        }else{
            let button1 = UIButton(frame:CGRect(x: 0, y: 0, width: 18, height: 18))
            button1.setBackgroundImage(UIImage(named: img!), for: UIControlState.normal)
            button1.isHighlighted=false
            button1.tag=(tag ?? 0)
            //button1.titleLabel?.font = UIFont.systemFontOfSize(17)
            button1.addTarget(self,action:#selector(onclick(_:)),for:.touchUpInside)
            let barButton1 = UIBarButtonItem(customView: button1)
            navigationItem.rightBarButtonItems=[barButton1]
        }
    }
    @objc func onclick(_ obj:UIButton){
        WXSDKManager.bridgeMgr().fireEvent(instance?.instanceId, ref: WX_SDK_ROOT_REF, type: "navclick", params: ["tag":obj.tag], domChanges: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        top=64
        weexHeight = self.view.frame.size.height - top!;
        //右侧按钮
        buildRightItem(title: rTitle, color: rColor, tag: rTag, img: rImg)
        //版本判断
        getJSBundle()
        
    }
    func getJSBundle(){
        if isLoading {return}
        isLoading=true
        //版本地址
        var urlVesion=url
        var num=url.positionOf(sub: "/", backwards: true)
        for c in "v/v." {
            num+=1
            urlVesion.insert(c, at:url.index(url.startIndex, offsetBy:num))
        }
        //获取版本信息
        restConn.restDelegate=self
        restConn.get(urlStr: urlVesion)
    }
    override func viewDidAppear(_ animated: Bool) {
        updateInstanceState(state: WXState.WeexInstanceAppear)
    }
    override func viewDidDisappear(_ animated: Bool) {
        updateInstanceState(state: WXState.WeexInstanceDisappear)
    }
    func updateInstanceState(state:WXState){
        if (instance != nil && instance?.state != state) {
            instance?.state = state;
            
            if (state == WXState.WeexInstanceAppear) {
                
                WXSDKManager.bridgeMgr().fireEvent(instance?.instanceId, ref: WX_SDK_ROOT_REF, type: "viewappear", params: ["haha":123], domChanges: nil)
            }
            else if (state == WXState.WeexInstanceDisappear) {
                WXSDKManager.bridgeMgr().fireEvent(instance?.instanceId, ref: WX_SDK_ROOT_REF, type: "viewdisappear", params: nil, domChanges: nil)
            }
        }
    }
    @objc public func setUrl(url: String){
        self.url=url
    }
    
    @objc public func okClick(){
        self.render()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        if instance != nil {
            instance!.destroy()
        }
    }
    
    public func render(){
        if instance != nil {
            instance!.destroy()
        }
        instance = WXSDKInstance()
        instance!.viewController = self
        let width = self.view.frame.size.width
        
        instance!.frame = CGRect(x:self.view.frame.size.width-width, y:top!, width:width, height:weexHeight!)
        weak var weakSelf:ViewController? = self
        instance!.onCreate = {
            (view:UIView!)-> Void in
            weakSelf!.weexView.removeFromSuperview()
            weakSelf!.weexView = view;
            weakSelf!.view.addSubview(self.weexView)
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf!.weexView)
        }
        instance!.onFailed = {
            (error:Error!)-> Void in
                print("faild at error: %@", error)
            }
        
        instance!.renderFinish = {
            (view:UIView!)-> Void in
            print("render finish")
        }
        instance!.updateFinish = {
            (view:UIView!)-> Void in
            print("update finish")
        }
        instance!.render(with: URL.init(string: String(format: "file://%@", self.filePath)), options: ["bundleUrl":self.url], data: nil)
    }
    public func down(){
        //判断文件是否存在
        let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentPath = documentPaths[0]
        let fileManager = FileManager.default
        filePath=documentPath+path+"/"+weexJSVesion.fileName
        if !fileManager.fileExists(atPath: filePath) {
            isGet=true
        }
        if isGet {
            isLoading=true
            restConn.down(urlStr: url, fileName: weexJSVesion.fileName, path: path)
        }else{
            render()
        }
    }
}
extension ViewController:RestConnDelegate {
    func onRequestSuccess(_ response: String?) {
        if response=="down" {
            //文件下载成功
            render()
        }else{
            weexJSVesion=WeexJSVesion(jsonStr: response!)
            if weexJSVesion != nil {
                //获取本地版本
                if let vesion=SharedData.getValue(key: weexJSVesion.fileName) {
                if weexJSVesion.md5==vesion {
                    isGet=false
                }else{
                    //更新版本号
                    isGet=true
                    SharedData.saveValue(versionCode: weexJSVesion.md5, key: weexJSVesion.fileName)
                }
                }else{
                //更新版本号
                isGet=true
                SharedData.saveValue(versionCode: weexJSVesion.md5, key: weexJSVesion.fileName)
                }
                down()
            }
        }
       isLoading=false
    }
    
    func onRequestError(_ error: Error?) {
        print("network error!")
        let alertController = UIAlertController(title: "系统提示",
                                                message: "网络异常", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        isLoading=false
    }
    
    
}
