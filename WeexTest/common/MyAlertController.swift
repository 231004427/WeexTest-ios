//
//  MyAlertController.swift
//  WeexTest
//
//  Created by 孙林 on 2018/4/9.
//  Copyright © 2018年 sunlin. All rights reserved.
//
import UIKit

class MyAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //标题字体样式（红色，字体放大）
        if self.title != nil {
        let titleFont = UIFont.systemFont(ofSize: 20)
        let titleAttribute = NSMutableAttributedString.init(string: self.title!)
        titleAttribute.addAttributes([NSAttributedStringKey.font:titleFont,
                                      NSAttributedStringKey.foregroundColor:UIColor.red],
                                     range:NSMakeRange(0, (self.title?.count)!))
        self.setValue(titleAttribute, forKey: "attributedTitle")
        }
        //消息内容样式（灰色斜体）
        let messageFontDescriptor = UIFontDescriptor.init(fontAttributes: [
            UIFontDescriptor.AttributeName.family:"Arial",
            UIFontDescriptor.AttributeName.name:"Arial-ItalicMT",
            ])
        
        let messageFont = UIFont.init(descriptor: messageFontDescriptor, size: 13.0)
        let messageAttribute = NSMutableAttributedString.init(string: self.message!)
        messageAttribute.addAttributes([NSAttributedStringKey.font:messageFont,
                                        NSAttributedStringKey.foregroundColor:UIColor.gray],
                                       range:NSMakeRange(0, (self.message?.count)!))
        self.setValue(messageAttribute, forKey: "attributedMessage")
    }
    override func addAction(_ action: UIAlertAction) {
        super.addAction(action)
        //let iconImage = UIImage(named:"tick")?.withRenderingMode(.alwaysOriginal)
        //action.setValue(iconImage, forKey: "image")
        //通过tintColor实现按钮颜色的修改。
        self.view.tintColor = UIColor.orange
        //也可以通过设置 action.setValue 来实现
        //action.setValue(UIColor.orange, forKey:"titleTextColor")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

