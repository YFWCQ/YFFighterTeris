//
//  YFTetrisShowView.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/2/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisShowView: UIView {

    var isFill:Bool = false
    
    var indexColorState:Int = -20
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func fill(model:YFTetrisMovingSceneModel) {
        isFill = true
        indexColorState = model.indexState
        self.backgroundColor = model.backGroudColor
    }
    func empty() {
        isFill = false
        indexColorState = -20
        self.backgroundColor = UIColor.clear
    }

}
