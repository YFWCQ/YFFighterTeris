//
//  YFBaseCubeModel.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/3/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFBaseCubeModel: NSObject {
    
    var dataArray:[YFTetrisMovingSceneModel] = []

    var isCanChangeToIndex:((Int,Int)->(Bool))!
    
    override init() {
        super.init()
    }
    
    init(canChangeBlock:@escaping ((Int,Int)->(Bool))) {
        super.init()
        isCanChangeToIndex = canChangeBlock
    }
    
    func changeStyle() {
        
    }
    
    func creatCube(beginXX:Int) -> [YFTetrisMovingSceneModel] {
    
        return []
    }

}
