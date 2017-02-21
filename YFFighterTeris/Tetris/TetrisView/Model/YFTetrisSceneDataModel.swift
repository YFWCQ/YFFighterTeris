//
//  YFTetrisSceneDataModel.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/10.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import UIKit

class YFTetrisSceneDataModel: NSObject {
    var sceneViewArray:[YFTerisBaModel] = []// 所有 方块的数组
    var sceneOpenArray:[YFTerisBaModel] = []// 所有没有被占用的 方块
    var sceneCloseArray:[YFTerisBaModel] = []// 所有已被 占用的 并且停止移动 方块
    var sceneIsMovingCloseArray:[YFTerisBaModel] = []// 所有被 占用的 正在移动的 方块

}
