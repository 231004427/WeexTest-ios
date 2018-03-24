//
//  JSON.swift
//  playcat
//
//  Created by 孙林 on 2017/11/27.
//  Copyright © 2017年 sunlin. All rights reserved.
//

import Foundation
//自定义一个JSON协议
protocol JSONP {
    func toJSONModel() -> AnyObject?
    func toJSONString() -> String?
}

//扩展协议方法
extension JSONP {
    //将数据转成可用的JSON模型
    func toJSONModel() -> AnyObject? {
        let mirror = Mirror(reflecting: self)
        if mirror.children.count > 0  {
            var result: [String:AnyObject] = [:]
            for case let (label?, value) in mirror.children {
                //print("属性：\(label)     值：\(value)")
                if let jsonValue = value as? JSONP {
                    result[label] = jsonValue.toJSONModel()
                }
            }
            
            return result as AnyObject
        }
        return self as AnyObject
    }
    
    //将数据转成JSON字符串
    func toJSONString() -> String? {
        let jsonModel = self.toJSONModel()
        //利用OC的json库转换成Data，
        let data = try? JSONSerialization.data(withJSONObject: jsonModel!,
                                               options: [])
        //Data转换成String打印输出
        let str = String(data: data!, encoding: .utf8)
        return str
    }
}

//扩展可选类型，使其遵循JSON协议
extension Optional: JSONP {
    //可选类型重写toJSONModel()方法
    func toJSONModel() -> AnyObject? {
        if let x = self {
            if let value = x as? JSONP {
                return value.toJSONModel()
            }
        }
        return nil
    }
}

//扩展两个自定义类型，使其遵循JSON协议

//扩展Swift的基本数据类型，使其遵循JSON协议
extension String: JSONP { }
extension Int: JSONP { }
extension Bool: JSONP { }
extension Dictionary: JSONP { }

//扩展Array，格式化输出
extension Array: JSONP {
    //将数据转成可用的JSON模型
    func toJSONModel() -> AnyObject? {
        var result: [AnyObject] = []
        for value in self {
            if let jsonValue = value as? JSONP , let jsonModel = jsonValue.toJSONModel(){
                result.append(jsonModel)
            }
        }
        return result as AnyObject
    }
}

//扩展Date日期类型，格式化输出
extension Date: JSONP {
    //将数据转成可用的JSON模型
    func toJSONModel() -> AnyObject? {
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: self)
        return datestr as AnyObject
    }
}
