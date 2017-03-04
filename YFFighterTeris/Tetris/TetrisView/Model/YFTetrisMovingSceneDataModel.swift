//
//  YFTetrisMovingSceneDataModel.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/10.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

let colorArray = [UIColor.green,UIColor.red,UIColor.purple,UIColor.orange,UIColor.cyan,UIColor.white]

class YFTetrisMovingSceneModel: NSObject {
    var xx:Int = 0
    var yy:Int = 0
    
    var indexState:Int = -20
    var backGroudColor:UIColor?
    
    init(x:Int,y:Int) {
        xx = x
        yy = y
        indexState = Int(arc4random() % 6) - 3
        backGroudColor = colorArray[indexState + 3]
    }
}

class YFTetrisMovingSceneDataModel: NSObject {
    var beginXX:Int = 3
    
    var dataArray:[YFTetrisMovingSceneModel] = []
    var dataViewArray:[YFTerisBaModel] = []
    
    
    
    //MARK: 2个方格的正方形
    func creatTwoCube() {
        dataArray.removeAll()
        for i in 0..<2 {
            let model = YFTetrisMovingSceneModel(x: beginXX + i % 2, y: -2 + i / 2)
            dataArray.append(model)
        }
    }

    
    //MARK: 四个方格的正方形
    func creatFourCube() {
        dataArray.removeAll()
        for i in 0..<4 {
            let model = YFTetrisMovingSceneModel(x: beginXX + i % 2, y: -2 + i / 2)
            dataArray.append(model)
        }
    }
    //MARK: I
    func creatICube() {
        dataArray.removeAll()
        for i in 0..<4 {
            let model = YFTetrisMovingSceneModel(x: beginXX , y: -4 + i)
            dataArray.append(model)
        }
    }
    //MARK: L
    func creatLCube() {
        dataArray.removeAll()
        for i in 0..<2 {
            let model = YFTetrisMovingSceneModel(x: beginXX + i % 2, y: -3 + i / 2)
            dataArray.append(model)
        }
        
        let model3 = YFTetrisMovingSceneModel(x: beginXX + 3 % 2, y: -3 + 3 / 2)
        dataArray.append(model3)
        
        let model4 = YFTetrisMovingSceneModel(x: beginXX + 5 % 2, y: -3 + 5 / 2)
        dataArray.append(model4)
        
    }

    
    func createArcStyle(){
        
        let arcIntNum = arc4random() % 3
        
        if arcIntNum == 0 {
            self.creatFourCube()
        }else if arcIntNum == 1
        {
            self.creatLCube()
        }else
        {
            self.creatICube()
        }
    }
    func removeAllModel(){
        self.dataArray.removeAll()
        self.dataViewArray.removeAll()
    }
    
    
//MARK: - 移动 方法
    // 下移动 1 步
    func downOneStep() {
        self.downSteps(step: 1)
    }
    
    // 下移 step 是步数
    func downSteps(step:Int) {
        for model in self.dataArray {
            model.yy += 1
        }
    }
    // 左移动 1 步
    func leftOneStep() {
        for model in self.dataArray {
            model.xx -= 1
        }
    }
    
    // 左移动 1 步
    func rightOneStep() {
        for model in self.dataArray {
            model.xx += 1
        }
    }

    
}
