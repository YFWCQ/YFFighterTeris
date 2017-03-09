//
//  ViewController.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var secenvView:YFTetrisSceneView!
    
    let panGesModel:YFPanGestureHandle = YFPanGestureHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        panGesModel.viewC = self
        
        //
        secenvView = YFTetrisSceneView(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width - 40, height: self.view.frame.size.height - 80))
        secenvView.horCount = 15
        secenvView.verCount = 25
        secenvView.creatSecenView()
        self.view.addSubview(secenvView)
        
        secenvView.backgroundColor = UIColor.purple
        
        // 移动手势,
        let pangesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesAction(sender:)))
        pangesture.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(pangesture)
        
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesAction(sender:)))
        self.view.addGestureRecognizer(tapGes)
    }
    
    func tapGesAction(sender:UIPanGestureRecognizer)  {
        
        secenvView.changeMovingStyle()
    }
    func panGesAction(sender:UIPanGestureRecognizer)  {

        let translation : CGPoint = sender.translation(in: self.view)
        if sender.state == UIGestureRecognizerState.began {
        // 从 0.0 开始
            panGesModel.handleMovedBeginPoint(point: translation)
//            print(translation)
        }else if sender.state == UIGestureRecognizerState.changed {
//            print(translation)
            panGesModel.handleMovedChangedPoint(point: translation)
        }else if sender.state == UIGestureRecognizerState.ended {
            
            panGesModel.handleMovedEndPoint(point: translation)
        }
    }
    func gesLeftAction(){
        
        self.secenvView.leftStep()
        
    }
    func gesRightAction(){
        
        self.secenvView.rightStep()
    }

    func gesDownAction(){
        
        self.secenvView.pullToBottom()
    }

    
    
    @IBAction func actionBegin(_ sender: Any) {
        secenvView.beginGame()
    }
    
    }

