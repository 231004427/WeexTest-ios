//
//  WXDivExtraComponent.swift
//  SwiftWeexSample
//
//  Created by zifan.zx on 2017/12/21.
//  Copyright © 2017年 com.taobao.weex. All rights reserved.
//

import Foundation
import UIKit
import WeexSDK
extension WXDivExtraComponent{
    
    open override  func loadView() -> UIView {
        return UITextView.init()
    }
    
    open override  func viewDidLoad() {
        let _uiTextView = self.view as! UITextView;
        _uiTextView.text="123123"
    }
}
