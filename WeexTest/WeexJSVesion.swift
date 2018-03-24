//
//  WeexJSVesion.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/24.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import SwiftyJSON
struct WeexJSVesion {
    var fileName:String=""
    var version:String=""
    var url:String=""
    var md5:String=""
    init(){
    }
    init(jsonStr:String){
        let jsonData=JSON(parseJSON:jsonStr)
        self.init(jsonData:jsonData)
    }
    init(jsonData:JSON) {
        fileName = jsonData["fileName"].stringValue
        version = jsonData["version"].stringValue
        url = jsonData["url"].stringValue
        md5 = jsonData["md5"].stringValue
    }
}
extension WeexJSVesion: JSONP { }
