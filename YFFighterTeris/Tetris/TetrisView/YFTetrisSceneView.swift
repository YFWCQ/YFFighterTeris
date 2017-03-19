//
//  YFTetrisSceneView.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisSceneView: UIView {
    // 已经沉到 底部的 方块
    let viewDataModel:YFTetrisSceneDataModel = YFTetrisSceneDataModel()
    
    // 正在 移动的 方块
    let viewMovingModel:YFTetrisMovingSceneDataModel = YFTetrisMovingSceneDataModel()
    
    
    var horCount:Int = 6 // 每行多少个
    var verCount:Int = 10   // 每列 多少个
    
    var timer:Timer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewMovingModel.beginXX = 3
    }
    
    func creatSecenView() {
        viewMovingModel.beginXX = horCount / 2
        weak var weakS = self
        timer = Timer.YF_scheduledTimerWithTimeInterval(0.2, closure: {
            weakS?.nextStepGame()
        }, repeats: true)
        
        timer.pauseTimer()
        
        let width = frame.size.width / CGFloat(horCount)
        let height = frame.size.height / CGFloat(verCount)
        
        for i in 0..<horCount*verCount {
            let xx = i % horCount
            let yy = i / horCount
            
            let terisModel = self.terisBaModelYF(xx: xx, yy: yy, frame: CGRect(x: width * CGFloat(xx), y: height * CGFloat(yy), width: width, height: height), superView: self)
            viewDataModel.sceneViewArray.append(terisModel)
        }
    }
    // MARK:- View
    
    func terisBaModelYF(xx:Int,yy:Int,frame:CGRect,superView:UIView) -> YFTerisBaModel {
        let terisBaModel = YFTerisBaModel(frame: frame,hIndex:xx,vIndex:yy)
        terisBaModel.addToSuperView(view: superView)
        terisBaModel.showView.empty()
        terisBaModel.verCount = verCount
        terisBaModel.horCount = horCount
        return terisBaModel
    }

    // MARK:- model
    func beginGame() {
     self.viewMovingModel.creatTwoCube()
     timer.resumeTimer()
    }
    
    func nextStepGame()-> Bool {
        if self.isCanDown(){
            self.clearAllfillView()
            self.viewMovingModel.downOneStep()
            self.fillAllfillView()
            return true
        }else
        {
            self.needSettingWhenisBottom()
        }
        return false
    }
    
    func clearAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * horCount
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let terisModel = self.viewDataModel.sceneViewArray[arrayXX]
                terisModel.showView.empty()
            }
        }
        self.viewMovingModel.dataViewArray.removeAll()
    }
    
    func fillAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * horCount
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let terisModel = self.viewDataModel.sceneViewArray[arrayXX]
                terisModel.showView.fill(model: model)
                self.viewMovingModel.dataViewArray.append(terisModel)
            }
        }
    }
    // 检查是否 到 最后，
    func checkIsBottomed() -> Bool {
        if self.isCanDown() == false{
           self.needSettingWhenisBottom()
            return true
        }
        return false
    }
    
    // 检查是否可以 下落
    func isCanDown() -> Bool {
        for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
        {
            // 是否到最后一行
            if closeViewOfMovingModel.verIndex! >= verCount - 1{
                return false
            }
            let downModel = self.viewDataModel.sceneViewArray[closeViewOfMovingModel.downIndex()]
            // 是否 有阻碍
            if self.viewDataModel.sceneCloseArray.contains(downModel)  {
                return false
            }
        }
        return true
    }
    // 检查是否可以 向左移动
    func isCanLeft() -> Bool {
        
        for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
        {
            let horVerIndx = closeViewOfMovingModel.horIndex
            
            // 是否到最后一行
            if horVerIndx! <= 0{
                return false
            }
            let leftIndex = closeViewOfMovingModel.leftIndex()
            let leftModel = self.viewDataModel.sceneViewArray[leftIndex]
            // 是否 有阻碍
            if leftModel.showView.isFill && self.viewMovingModel.dataViewArray.contains(leftModel) == false {
                return false
            }
        }
        return true
    }
    // 左移一步
    func leftStep()  {
        if self.isCanLeft() {
            self.clearAllfillView()
            self.viewMovingModel.leftOneStep()
            self.fillAllfillView()
        }

    }
    
    // 检查是否可以 向右移动
    func isCanRight() -> Bool {
        
        for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
        {
            let horVerIndx = closeViewOfMovingModel.horIndex
            
            // 是否到最后一行
            if horVerIndx! >= horCount - 1{
                return false
            }
            let rightIndex = closeViewOfMovingModel.rightIndex()
            let rightModel = self.viewDataModel.sceneViewArray[rightIndex]
            // 是否 有阻碍
            if rightModel.showView.isFill && self.viewMovingModel.dataViewArray.contains(rightModel) == false {
                return false
            }
        }
        return true
    }
    // 右移一步
    func rightStep()  {
        if self.isCanRight() {
            self.clearAllfillView()
            self.viewMovingModel.rightOneStep()
            self.fillAllfillView()
        }
    }

    
    
    
    func needSettingWhenisBottom()
    {
        // 首先检测有没有失败
        for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
        {
            if closeViewOfMovingModel.verIndex <= 0 {
                self.gameOver()
                return
            }
        }
        
        self.rememberIsBottomedOfMovingModel()
        self.viewMovingModel.removeAllModel()
        self.viewMovingModel.createArcStyle()
    }
    
    func rememberIsBottomedOfMovingModel() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * horCount
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let subModel = self.viewDataModel.sceneViewArray[arrayXX]
               
                self.viewDataModel.sceneCloseArray.append(subModel)
            }
        }
    }
    
    
    func gameOver() {
        
        self.timer.pauseTimer()
        
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        let alertVC:UIAlertController = UIAlertController(title: "失败", message: "完蛋了", preferredStyle: UIAlertControllerStyle.alert)
        
        alertVC.addAction(UIAlertAction(title: "哦", style: UIAlertActionStyle.cancel, handler: nil))
        
        delegate.window?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    // 快速下落
    func pullToBottom() {
        for _ in 0...verCount {
            if self.nextStepGame() == false {
             break
            }
        }
    }
    
    func pullToLeft() {
        
    }

    func pullToRight() {
        
    }
    
    func changeMovingStyle()
    {
        self.clearAllfillView()
        viewMovingModel.movingModelManager?.changeStyle()
        self.fillAllfillView()
        print("点击")
    }
}
