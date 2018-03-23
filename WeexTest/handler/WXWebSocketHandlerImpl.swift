//
//  WXWebSocketHandler.swift
//  WeexTest
//
//  Created by 孙林 on 2018/3/18.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
import WeexSDK
import Starscream
class WXWebSocketHandlerImpl: NSObject,WXWebSocketHandler {
    var socket:WebSocket!
    func open(_ url: String!, protocol: String!, identifier: String!, with delegate: WXWebSocketDelegate!) {
        print("open");
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 5
        request.setValue("someother protocols", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        request.setValue("14", forHTTPHeaderField: "Sec-WebSocket-Version")
        request.setValue("Everything is Awesome!", forHTTPHeaderField: "My-Awesome-Header")
        socket = WebSocket(request: request)
        
        //websocketDidConnect
        socket.onConnect = {
            print("websocket is connected")
            delegate.didOpen()
        }
        //websocketDidDisconnect
        socket.onDisconnect = { (error: Error?) in
            print("websocket is disconnected: \(error?.localizedDescription ?? "")")
            delegate.didFailWithError(error)
        }
        //websocketDidReceiveMessage
        socket.onText = { (text: String) in
            print("got some text: \(text)")
            delegate.didReceiveMessage(text)
        }
        //websocketDidReceiveData
        socket.onData = { (data: Data) in
            print("got some data: \(data.count)")
            delegate.didReceiveMessage(data)
        }
        //you could do onPong as well.
        socket.connect()
    }
    
    func send(_ identifier: String!, data: String!) {
        print("send");
        socket.write(string: data)
    }
    
    func close(_ identifier: String!) {
        print("close");
        socket.disconnect()
    }
    
    func close(_ identifier: String!, code: Int, reason: String!) {
        print("close");
        socket.disconnect()
    }
    
    func clear(_ identifier: String!) {
        print("clear");
        socket.disconnect()
    }
    
    
}
