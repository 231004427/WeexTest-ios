//
//  MyProgressHUDLoading.swift
//  playcat
//
//  Created by 孙林 on 2017/12/5.
//  Copyright © 2017年 sunlin. All rights reserved.
//

import Foundation
class MyProgressHUDLoading {
    let hud:MBProgressHUD!
    var imageView:UIImageView!
    let view:UIView!
    init(_ to: UIView,_ isCancel:Bool=false) {
        view=to
        imageView=UIImageView()
        hud=MBProgressHUD(view: to)
        BuildLoading(isCancel)
    }
    //自定义提示
    func BuildLoading(_ isCancel:Bool){
        //初始化对话框，置于当前的View当中
        hud.mode = MBProgressHUDMode.customView
        hud.backgroundView.style = .solidColor
        //如果设置此属性，则当前view置于后台
        hud.backgroundColor = SWColor(hexString: "#ffffff", alpha: 0.6)
        hud.bezelView.style=MBProgressHUDBackgroundStyle.solidColor
        hud.bezelView.backgroundColor=SWColor(hexString: "#000000", alpha: 0.0)
        var images=[UIImage]()
        for i in 1...15 {
            images.append(UIImage(named: "loading\(i)")!)
        }
        imageView.animationImages=images
        imageView.animationDuration=0.8
        imageView.animationRepeatCount=0
        hud.customView = imageView
        if isCancel {
            let viewBackground=hud.backgroundView
            viewBackground.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGestureAction))
            tapGesture.numberOfTapsRequired = 1
            viewBackground.addGestureRecognizer(tapGesture)
        }
    }
    func show(){
        view.addSubview(hud)
        imageView.startAnimating()
        hud.show(animated: true)
    }
    func hide(){
        imageView.stopAnimating()
        hud.hide(animated: true, afterDelay: 0)
    }
    @objc func tapGestureAction(){
        hud.hide(animated: true, afterDelay: 0)
    }
}
class MYProgressHUD:MBProgressHUD{
    static func showMessage(_ view:UIView,_ str:String,_ delegate:MBProgressHUDDelegate){
        let hudObj = MBProgressHUD.showAdded(to: view, animated: true)
        hudObj.mode=MBProgressHUDMode.text
        hudObj.bezelView.backgroundColor=SWColor(hexString: "#000000", alpha: 0.5)
        hudObj.label.text = str
        hudObj.label.lineBreakMode = NSLineBreakMode.byWordWrapping
        hudObj.label.numberOfLines = 0
        hudObj.label.textColor=SWColor.white
        hudObj.delegate=delegate
        hudObj.hide(animated: true, afterDelay: 3)
    }
    static func showMessage(_ view:UIView,_ str:String)
    {
        let hudObj = MBProgressHUD.showAdded(to: view, animated: true)
        hudObj.mode=MBProgressHUDMode.text
        hudObj.bezelView.style = MBProgressHUDBackgroundStyle.solidColor
        hudObj.bezelView.color=UIColor(hexString: "#000000", alpha: 0.8)!
        hudObj.label.text = str
        hudObj.label.lineBreakMode = NSLineBreakMode.byWordWrapping
        hudObj.label.numberOfLines = 0
        hudObj.label.textColor=SWColor.white
        hudObj.hide(animated: true, afterDelay: 3)
    }
}
