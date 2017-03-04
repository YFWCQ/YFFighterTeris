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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func fill(model:YFTetrisMovingSceneModel) {
        isFill = true
        self.backgroundColor = model.backGroudColor
    }
    func empty() {
        isFill = false
        self.backgroundColor = UIColor.clear
    }

}
