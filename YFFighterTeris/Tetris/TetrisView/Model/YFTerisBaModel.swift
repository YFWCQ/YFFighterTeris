//
//  YFTerisBaModel.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/2/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

// 每一个 小方格 对应一个Model
class YFTerisBaModel: NSObject {

    var backGView:YFTetrisBackView!
    
    var showView:YFTetrisShowView!
    // 横坐标
    var horIndex:Int! = 0
    // 横轴数量
    var horCount:Int! = 0
  
    // 纵坐标
    var verIndex:Int! = 0
    // 纵轴数量
    var verCount:Int! = 0
    
    init(frame:CGRect,hIndex:Int,vIndex:Int) {
    
        super.init()
        
        backGView = YFTetrisBackView(frame: frame)
        
        showView = YFTetrisShowView(frame: frame)
        
        horIndex = hIndex
        verIndex = vIndex
    }
    
   
    func addToSuperView(view:UIView) {
     view.addSubview(backGView)
     view.addSubview(showView)
    }
    
    func downIndex() -> Int {
        
        return  (verIndex + 1) * horCount + horIndex
    }
    
    func leftIndex() -> Int {
        
        return  verIndex * horCount + horIndex - 1
    }
    
    func rightIndex() -> Int {
        
        return  verIndex * horCount + horIndex + 1
    }

    func arrayIndex() -> Int {
        
        return  verIndex * horCount + horIndex
    }
    
    
    
    
    
}
