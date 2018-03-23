//
//  WxImageDownloader.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/2.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import UIKit
import WeexSDK
import Kingfisher

class WXImageOperation: NSObject, WXImageOperationProtocol {
    var task: RetrieveImageDownloadTask?
    init(task: RetrieveImageDownloadTask?) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
}
class WXXCassetsLoaderOperation: NSObject, WXImageOperationProtocol {
    func cancel() {
    }
}
class WxImageDownloader: NSObject, WXImgLoaderProtocol {

    func downloadImage(withURL url: String!, imageFrame: CGRect, userInfo options: [AnyHashable : Any]! = [:], completed completedBlock: ((UIImage?, Error?, Bool) -> Void)!) -> WXImageOperationProtocol! {
        
        if url.positionOf(sub: "file:") >= 0 {
            do{
                let result =  try Data(contentsOf: URL(string: url)!, options: Data.ReadingOptions.uncached)
                 let image = UIImage(data: result)
                completedBlock(image,nil,true)
                return WXXCassetsLoaderOperation()
            }catch{
                return nil
            }

        }
        if url.contains("asserts:") {
            
            let completeURL=URL(string: url)
            let image=UIImage(named: completeURL!.host!)
            completedBlock(image,nil,true)
            return WXXCassetsLoaderOperation()
        }
        return WXImageOperation.init(task: ImageDownloader.default.downloadImage(with: URL.init(string: url)!, completionHandler: { (image, error, url, data) in
            completedBlock?(image, error, data != nil ? true : false)
        }))
    }
}
