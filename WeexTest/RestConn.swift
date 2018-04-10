//
//  RestConn.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/24.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
protocol RestConnDelegate:class {
    func onRequestSuccess(_ response:String?)
    func onRequestError(_ error:Error?)
}
class RestConn:NSObject {
    let TAG="RestAlamofire"
    weak var restDelegate:RestConnDelegate? = nil
}
extension RestConn{
    func down(urlStr:String,fileName:String!,path:String!){
        
        // 1、创建URL对象；
        let url:URL! = URL(string:urlStr);
        
        // 2、创建Request对象
        // url: 请求路径
        // cachePolicy: 缓存协议
        // timeoutInterval: 网络请求超时时间(单位：秒)
        var urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod="GET"
        //3.获得会话对象
        let session: URLSession = URLSession.shared
        
        //4.根据会话对象创建一个Task(发送请求）
        /*
         第一个参数：请求对象
         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         data：响应体信息（期望的数据）
         response：响应头信息，主要是对服务器端的描述
         error：错误信息，如果请求失败，则error有值
         */
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if error != nil{
                    self.restDelegate?.onRequestError(error)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    //操作文件
                    let documentPaths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                    let documentPath = documentPaths[0]
                    let fileManager = FileManager.default
                    let mydir = documentPath+path
                    do {
                        try fileManager.createDirectory(atPath: mydir, withIntermediateDirectories: true, attributes: nil)
                        try str!.write(toFile: mydir+"/"+fileName, atomically: true, encoding: String.Encoding.utf8)
                        self.restDelegate?.onRequestSuccess("down")
                    }catch{
                        self.restDelegate?.onRequestError(error)
                    }
                    //LogC.w(str ?? "",self.TAG)
                }
            })
        }
        //使用resume方法启动任务
        dataTask.resume()
    }
    //========================================Get==========================================//
    //MARK: - Get方式
    func get(urlStr:String){
        
        //urlStr=urlStr.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        // 1、创建URL对象；
        let url:URL! = URL(string:urlStr);
        
        // 2、创建Request对象
        // url: 请求路径
        // cachePolicy: 缓存协议
        // timeoutInterval: 网络请求超时时间(单位：秒)
        var urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod="GET"
        //3.获得会话对象
        let session: URLSession = URLSession.shared
        
        //4.根据会话对象创建一个Task(发送请求）
        /*
         第一个参数：请求对象
         第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
         data：响应体信息（期望的数据）
         response：响应头信息，主要是对服务器端的描述
         error：错误信息，如果请求失败，则error有值
         */
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if error != nil{
                    self.restDelegate?.onRequestError(error)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    self.restDelegate?.onRequestSuccess(str)
                    //LogC.w(str ?? "",self.TAG)
                }
            })
        }
        //使用resume方法启动任务
        dataTask.resume()
    }
    //========================================Post==========================================//
    //print(str.removingPercentEncoding)
    //MARK: - Post方式
    func post(str:String,urlStr:String) {
        let url:URL! = URL(string:urlStr);
        var urlRequest:URLRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod="POST"
        urlRequest.setValue("ios", forHTTPHeaderField:"User-Agent")
        urlRequest.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        //let strTemp=str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        urlRequest.httpBody = str.data(using: .utf8)
        let session: URLSession = URLSession.shared
        let dataTask: URLSessionDataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async(execute: {
                if error != nil{
                    self.restDelegate?.onRequestError(error)
                }else{
                    let str = String(data: data!, encoding: String.Encoding.utf8)
                    self.restDelegate?.onRequestSuccess(str)
                    //LogC.w(str ?? "",self.TAG)
                }
            })
        }
        //使用resume方法启动任务
        dataTask.resume()
    }
}
