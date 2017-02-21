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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        secenvView = YFTetrisSceneView(frame: CGRect(x: 20, y: 20, width: self.view.frame.size.width - 40, height: self.view.frame.size.height - 80))
        secenvView.column = 15
        secenvView.row = 25
        secenvView.creatSecenView()
        self.view.addSubview(secenvView)
        
        secenvView.backgroundColor = UIColor.purple
        
    }

    @IBAction func actionBegin(_ sender: Any) {
        secenvView.beginGame()
    }
}

