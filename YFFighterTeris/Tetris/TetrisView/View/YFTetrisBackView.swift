//
//  YFTetrisBackView.swift
//  YFFighterTeris
//
//  Created by FYWCQ on 17/2/20.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisBackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }


    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        superview?.sendSubview(toBack: self)
    }
}
