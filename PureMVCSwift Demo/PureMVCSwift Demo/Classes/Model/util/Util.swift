//
//  Util.swift
//  PureMVCSwift Demo
//
//  Created by Stephan Schulz on 07.10.14.
//  Copyright (c) 2014 Stephan Schulz. All rights reserved.
//

import Foundation

typealias dispatch_cancelable_closure = (cancel : Bool) -> ()

func delay(time:NSTimeInterval, closure:()->()) ->  dispatch_cancelable_closure?
{
    
    func dispatch_later(clsr:()->())
    {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), clsr)
    }
    
    var closure:dispatch_block_t? = closure
    var cancelableClosure:dispatch_cancelable_closure?
    
    let delayedClosure:dispatch_cancelable_closure = { cancel in
        if let clsr = closure
        {
            if (cancel == false)
            {
                dispatch_async(dispatch_get_main_queue(), clsr);
            }
        }
        closure = nil
        cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    dispatch_later
        {
            if let delayedClosure = cancelableClosure
            {
                delayedClosure(cancel: false)
            }
    }
    
    return cancelableClosure;
    
}
