//
//  JSONHelp.swift
//  playcat
//
//  Created by 孙林 on 2017/11/27.
//  Copyright © 2017年 sunlin. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONHelp {
    
}
extension JSON {
    //Non-optional string
    public var dateValue: Date? {
        get {
            switch self.type {
            case .string:
                let strValue=self.object as? String ?? ""
                if strValue != "" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale.current
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    return dateFormatter.date(from: strValue)
                }
                return nil
            default:
                return nil
            }
        }
    }
}
