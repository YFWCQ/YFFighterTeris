//
//  ExtensionTimer.swift
//  YFTetris
//
//  Created by FYWCQ on 17/1/12.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

import Foundation
import UIKit

public typealias TimerExcuteClosure = @convention(block) () -> ()

extension Timer{
    
    private class TimerActionBlockWrapper : NSObject {
        var block : TimerExcuteClosure
        init(block: @escaping TimerExcuteClosure) {
            self.block = block
        }
    }
    
    public class func YF_scheduledTimerWithTimeInterval(_ ti:TimeInterval, closure: @escaping TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer {
        return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(Timer.excuteTimerClosure(_:)), userInfo: TimerActionBlockWrapper(block: closure), repeats: true)
    }
    @objc private class func excuteTimerClosure(_ timer: Timer) {
        if let action = timer.userInfo as? TimerActionBlockWrapper {
            action.block()
        }
    }
    
    func pauseTimer() {
        if !self.isValid {
            return;
        }
        self.fireDate = NSDate.distantFuture
    }
    
    func resumeTimer() {
        if !self.isValid {
            return;
        }
        self.fireDate = NSDate.distantPast
    }
    
    func resumeTimerAfterTimeInterval(time:TimeInterval) {
        if !self.isValid {
            return;
        }
        self.fireDate = NSDate(timeIntervalSinceNow: time) as Date
    }
    
}
