//
//  YFPanGestureHandle.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/3/2.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

let gapLimeteToStep:CGFloat = 30.0

class YFPanGestureHandle: NSObject {

    var startPoint:CGPoint = CGPoint(x: 0, y: 0)// 默认 是 00
    var changePoint:CGPoint = CGPoint(x: 0, y: 0)// 默认 是 00
    var endPoint:CGPoint = CGPoint(x: 0, y: 0)
    
    
    weak var viewC:ViewController?
    
    func handleMovedBeginPoint(point:CGPoint){
        startPoint = point
        changePoint = point
    }
    func handleMovedChangedPoint(point:CGPoint){
        changePoint = point
        self.resultPoint(lastPoint: changePoint)
    }
    func handleMovedEndPoint(point:CGPoint){
        endPoint = point
        
    }
    
    func resultPoint(lastPoint:CGPoint){
        let gapx = lastPoint.x - startPoint.x
        let gapy = lastPoint.y - startPoint.y
        
        if abs(gapx) <= gapLimeteToStep &&  abs(gapy) <= gapLimeteToStep{
            return;
        }
        // 重新记录开始坐标，下次根据这次的记录计算 方向
        startPoint = lastPoint
        if abs(gapx) > abs(gapy){
            if gapx > 0
            {
                print("右")
                viewC?.gesRightAction()
            }else
            {
                print("左")
                viewC?.gesLeftAction()
            }
        }else
        {
            if gapy > 0{
                print("下")
                viewC?.gesDownAction()
            }

        }
    }
    
}
