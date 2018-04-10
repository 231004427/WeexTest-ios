//
//  WXPickerSheetModule.swift
//  WeexTest
//
//  Created by 孙林 on 2018/4/9.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK
import UIKit
public extension WXPickerSheetModule{
    @objc public func pick(_ param:NSDictionary,_ callback: WXModuleCallback?){
        var index=param["index"] as? Int
        var items=[String]()
        items=param["items"] as! [String]
        for item in items{
            print("\(item)")
        }
        
        let pickerView=SelectPickerView.addTo(superView: weexInstance.viewController.view)
        pickerView.show()
        let data=["index":1,"value":"sun"] as [String : Any]
        callback?(data)
    }
}
