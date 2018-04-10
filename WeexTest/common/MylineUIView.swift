//
//  MylineUIView.swift
//  playcat
//
//  Created by 孙林 on 2017/11/30.
//  Copyright © 2017年 sunlin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class MylineUIView:UIView{
    @IBInspectable var type : Int = 0
    private func build(){
        let frame = self.frame
        self.backgroundColor=SWColor(hexString: "#C8C7CC")
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 1.0/UIScreen.main.scale)
        
    }
    private func drawLine(from: CGPoint,to: CGPoint,path:UIBezierPath){
        let color=SWColor(hexString: "#C8C7CC")
        color?.set()
        path.move(to: from)
        path.addLine(to: to)
        path.stroke()
    }
    override func updateConstraints() {
        super.updateConstraints()
    }
    override func draw(_ rect: CGRect) {
        let path=UIBezierPath()
        path.lineWidth=1.0/UIScreen.main.scale
        var startPoint:CGPoint=CGPoint(x:0,y:0)
        var endPoint:CGPoint=CGPoint(x:0,y:0)
        if type==0 {
            startPoint.x=0
            startPoint.y=rect.height
            endPoint.x=rect.width
            endPoint.y=startPoint.y-path.lineWidth
            drawLine(from: startPoint, to: endPoint, path: path)
        }
        if type==1 {
            startPoint.x=0
            startPoint.y=0
            endPoint.x=bounds.size.width
            endPoint.y=startPoint.y
            drawLine(from: startPoint, to: endPoint, path: path)
        }
        if type==2{
            startPoint.x=0
            startPoint.y=0
            endPoint.x=bounds.size.width
            endPoint.y=startPoint.y
            drawLine(from: startPoint, to: endPoint, path: path)
            
            startPoint.x=0
            startPoint.y=rect.height
            endPoint.x=rect.width
            endPoint.y=startPoint.y-path.lineWidth
            drawLine(from: startPoint, to: endPoint, path: path)
        }
        /*
         //获取画笔上下文
         let context:CGContext =  UIGraphicsGetCurrentContext()!
         context.setAllowsAntialiasing(true) //抗锯齿设置
         
         //绘制直线
         context.setStrokeColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1 );//设置画笔颜色方法一
         context.setLineWidth(1);//线条宽度
         context.move(to: CGPoint(x: 10, y: 40))//开始点位置
         context.addLine(to: CGPoint(x: 100, y: 40))//结束点位置
         context.strokePath();*/
    }
}

