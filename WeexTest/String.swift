//
//  String.swift
//  MyFrame
//
//  Created by 孙林 on 2017/4/3.
//  Copyright © 2017年 sunlin. All rights reserved.
//

import Foundation
extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    func subString(to index: String.Index) -> String {
        let st = self.startIndex
        let en = index
        return String(self[st ..< en])
    }
    func subString(from index: String.Index) -> String {
        let st = index
        let en = self.endIndex
        return String(self[st ..< en])
    }
    public func subString(with aRange: Range<String.Index>) -> String {
        return String(self[aRange])
    }
    func subString(start:Int, length:Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy:start)
        let en = self.index(st, offsetBy:len)
        return String(self[st ..< en])
    }
}
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    func withHeightConstrainedHeight(height:CGFloat,font:UIFont)->CGFloat{
        let size = CGSize(width:900,height:height)
        let dic = [NSAttributedStringKey.font: font]
        let strSize = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context: nil)
        return strSize.width
    }
}
extension String {
    //返回第一次出现的指定子字符串在此字符串中的索引
    //（如果backwards参数设置为true，则返回最后出现的位置）
    func positionOf(sub:String, backwards:Bool = false)->Int {
        var pos = -1
        if let range = range(of:sub, options: backwards ? .backwards : .literal ) {
            if !range.isEmpty {
                pos = self.distance(from:startIndex, to:range.lowerBound)
            }
        }
        return pos
    }
}

