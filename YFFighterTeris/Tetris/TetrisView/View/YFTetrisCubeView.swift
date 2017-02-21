//
//  YFTetrisCubeView.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisCubeView: UIView {
    var isFill:Bool = false
    var xx:Int = 0
    var yy:Int = 0
    
    func fill() {
        isFill = true
       self.backgroundColor = UIColor.purple
    }
    func empty() {
        isFill = false
        self.backgroundColor = UIColor.gray
    }
}
