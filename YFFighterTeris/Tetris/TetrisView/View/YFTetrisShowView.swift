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
    var xx:Int = 0
    var yy:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    func fill() {
        isFill = true
        self.backgroundColor = UIColor.purple
    }
    func empty() {
        isFill = false
        self.backgroundColor = UIColor.clear
    }

}
