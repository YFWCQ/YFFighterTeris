//
//  YFTwoCubeModel.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/3/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTwoCubeModel: YFBaseCubeModel {

    
    override func changeStyle() {
        
        let firstModel = dataArray[0]
        let secondModel = dataArray[1]
        
        
        
        if firstModel.xx < secondModel.xx && firstModel.yy == secondModel.yy
        {
            // 保证不过界
            if self.isCanChangeToIndex(secondModel.xx,secondModel.yy + 1) {
                firstModel.xx = secondModel.xx
                firstModel.yy = secondModel.yy + 1
            }
        }
        else if firstModel.xx == secondModel.xx &&  firstModel.yy > secondModel.yy
        {
            if self.isCanChangeToIndex(secondModel.xx + 1,secondModel.yy) {
                firstModel.xx = secondModel.xx + 1
                firstModel.yy = secondModel.yy
            }
         }
        else if firstModel.xx > secondModel.xx && firstModel.yy == secondModel.yy
        {
            if self.isCanChangeToIndex(secondModel.xx,secondModel.yy - 1) {
                firstModel.xx = secondModel.xx
                firstModel.yy = secondModel.yy - 1
            }
        }
        else
        {
            if self.isCanChangeToIndex(secondModel.xx - 1,secondModel.yy) {
                firstModel.xx = secondModel.xx - 1
                firstModel.yy = secondModel.yy
            }
        }
    }
    
    override func creatCube(beginXX: Int) -> [YFTetrisMovingSceneModel] {
        
        dataArray.removeAll()
        for i in 0..<2 {
            let model = YFTetrisMovingSceneModel(x: beginXX + i % 2, y: -2 + i / 2)
            dataArray.append(model)
        }
        return dataArray
    }
}
