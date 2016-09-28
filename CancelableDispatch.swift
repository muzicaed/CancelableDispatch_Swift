//
//  CancelableDispatch.swift
//
//  Created by Mikael Hellman on 2015-05-13.
//  Port of Sebastien Thiebaud's objC dispatch_cancelable_block
//  Credits: https://github.com/SebastienThiebaud/dispatch_cancelable_block
//

import Foundation

typealias dispatchCancelableClosure = (_ cancel : Bool) -> Void

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
  class func delayBlock(_ time: TimeInterval, closure: @escaping () -> Void) -> dispatchCancelableClosure? {
    let closure: ()->()? = closure
    var cancelableClosure: dispatchCancelableClosure?
    
    let delayedClosure: dispatchCancelableClosure = { (cancel) in
        if (cancel == false) {
            DispatchQueue.main.async {
                closure()
            }
        }
      cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    CancelableDispatch.dispatchLater(time) {
      if let delayedClosure = cancelableClosure {
        delayedClosure(false)
      }
    }
    
    return cancelableClosure;
  }
  
  /**
  * Cancel a already sheduled execution.
  */
  class func cancelDelay(_ closure: dispatchCancelableClosure?) {
    if let closure = closure {
      closure(true)
    }
  }
  
  fileprivate class func dispatchLater(_ time: TimeInterval, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
      deadline: DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
  }
}
