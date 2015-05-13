//
//  CancelableDispatch.swift
//
//  Created by Mikael Hellman on 2015-05-13.
//  Port of Sebastien Thiebaud's objC dispatch_cancelable_block
//  Credits: https://github.com/SebastienThiebaud/dispatch_cancelable_block
//

import Foundation

typealias dispatchCancelableClosure = (cancel : Bool) -> Void

/**
* Port of Sebastien Thiebaud's objC dispatch_cancelable_block
* Credits: https://github.com/SebastienThiebaud/dispatch_cancelable_block
*/
class CancelableDispatch {
  
  /**
  * Prevent instance.
  */
  init() {
    fatalError("CancelableDispatch should not be instantiated.")
  }
  
  /**
  * Schedules execution of a code block (closure) and offers
  * a possibility to cancel execution.
  */
  class func delayBlock(time: NSTimeInterval, closure: () -> Void) -> dispatchCancelableClosure? {
    var closure: dispatch_block_t? = closure
    var cancelableClosure: dispatchCancelableClosure?
    
    let delayedClosure: dispatchCancelableClosure = { (cancel) in
      if let closure = closure {
        if (cancel == false) {
          dispatch_async(dispatch_get_main_queue(), closure);
        }
      }
      closure = nil
      cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    CancelableDispatch.dispatchLater(time) {
      if let delayedClosure = cancelableClosure {
        delayedClosure(cancel: false)
      }
    }
    
    return cancelableClosure;
  }
  
  /**
  * Cancel a already sheduled execution.
  */
  class func cancelDelay(closure: dispatchCancelableClosure?) {
    if let closure = closure {
      closure(cancel: true)
    }
  }
  
  private class func dispatchLater(time: NSTimeInterval, closure: () -> Void) {
    dispatch_after(
      dispatch_time(
        DISPATCH_TIME_NOW,
        Int64(time * Double(NSEC_PER_SEC))
      ),
      dispatch_get_main_queue(), closure)
  }
}