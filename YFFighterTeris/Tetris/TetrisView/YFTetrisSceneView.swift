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
    
    var column:Int = 6 // 6列
    var row:Int = 10   // 10 行
    
    var timer:Timer!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewMovingModel.beginXX = 3
    }
    
    func creatSecenView() {
        viewMovingModel.beginXX = column / 2
        weak var weakS = self
        timer = Timer.YF_scheduledTimerWithTimeInterval(0.2, closure: {
            weakS?.nextStepGame()
        }, repeats: true)
        
        timer.pauseTimer()
        
        let width = frame.size.width / CGFloat(column)
        let height = frame.size.height / CGFloat(row)
        
        for i in 0..<column*row {
            let xx = i % column
            let yy = i / column
            
            let terisModel = self.terisBaModelYF(xx: xx, yy: yy, frame: CGRect(x: width * CGFloat(xx), y: height * CGFloat(yy), width: width, height: height), superView: self)
            viewDataModel.sceneViewArray.append(terisModel)
        }
    }
    // MARK:- View
//    func sceneViewYF(index:Int,frame:CGRect) -> YFTetrisCubeView {
//        let sceneView = YFTetrisCubeView(frame: frame)
//        
//        sceneView.layer.borderColor = UIColor.blue.cgColor
//        sceneView.layer.borderWidth = 0.5
//    
//        return sceneView
//    }
    
    func terisBaModelYF(xx:Int,yy:Int,frame:CGRect,superView:UIView) -> YFTerisBaModel {
        let terisBaModel = YFTerisBaModel(frame: frame,hIndex:xx,vIndex:yy)
        terisBaModel.addToSuperView(view: superView)
        terisBaModel.showView.empty()
        terisBaModel.verCount = row
        terisBaModel.horCount = column
        return terisBaModel
    }

    // MARK:- model
    func beginGame() {
     self.viewMovingModel.createArcStyle()
        timer.resumeTimer()
    }
    
    func nextStepGame(){
        
        self.clearAllfillView()
        self.viewMovingModel.downOneStep()
        self.fillAllfillView()
        self.checkIsBottomed()
    }
    
    func clearAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let terisModel = self.viewDataModel.sceneViewArray[arrayXX]
                terisModel.showView.empty()
            }
        }
        self.viewMovingModel.dataViewArray.removeAll()
    }
    
    func fillAllfillView() {
        for model in self.viewMovingModel.dataArray {
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let terisModel = self.viewDataModel.sceneViewArray[arrayXX]
                terisModel.showView.fill()
                self.viewMovingModel.dataViewArray.append(terisModel)
            }
        }
    }
    // 检查是否 到 最后，
    func checkIsBottomed() {
        
        
        for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
        {
            let nextVerIndx = closeViewOfMovingModel.verIndex
            
//            if downIndx > 0 && {
//                <#code#>
//            }
            
            if nextVerIndx! >= row - 1{
                self.needSettingWhenisBottom()
                return
            }
            
            let downIndex = closeViewOfMovingModel.downIndex()
//            print(downIndex)
//            print(self.viewDataModel.sceneViewArray.count)
            let downModel = self.viewDataModel.sceneViewArray[downIndex]
            
            if self.viewDataModel.sceneCloseArray.contains(downModel) {
                self.needSettingWhenisBottom()
                return
            }
            
        }
        
//        // 检查已经被占用的方块和 正在移动的方块 有没有 相邻
//            for closeViewOfMovingModel in self.viewMovingModel.dataViewArray
//            {
//                for closeViewModel in self.viewDataModel.sceneCloseArray {
//                    if closeViewModel.verIndex - closeViewOfMovingModel.verIndex <= 1 && closeViewModel.horIndex == closeViewOfMovingModel.horIndex {
//                        self.needSettingWhenisBottom()
//                        return
//                    }
//                }
//            }
//
//        if let model = self.viewMovingModel.dataArray.last
//        {
//            // 是否下落到 不能再下落的 地方了
//            if model.yy == self.row - 1 {
//              self.needSettingWhenisBottom()
//            }
//        }
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
            let arrayXX = model.xx + model.yy * column
            if arrayXX >= 0  && self.viewDataModel.sceneViewArray.count > arrayXX{
                let view = self.viewDataModel.sceneViewArray[arrayXX]
               
                self.viewDataModel.sceneCloseArray.append(view)
            }
        }
    }
    
    
    func gameOver() {
        
        self.timer.pauseTimer()
        
        let delegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        UIAlertController.init(title: "失败", message: "完蛋了", preferredStyle: UIAlertControllerStyle.alert).show((delegate.window?.rootViewController)!, sender: nil)
    }
    
    
}
