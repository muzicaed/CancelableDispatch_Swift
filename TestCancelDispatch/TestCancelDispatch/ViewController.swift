//
//  ViewController.swift
//  TestCancelDispatch
//
//  Created by BinaryBoy on 9/28/16.
//  Copyright © 2016 BinaryBoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayOfBlocks: [dispatchCancelableClosure] = [dispatchCancelableClosure]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for count:Int in 1 ..< 10 {
        let printBlock = CancelableDispatch.delayBlock(Double(count * 2), closure: {

                print("\(count)")
        })
        arrayOfBlocks.append(printBlock!)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelAllAction(_ sender: AnyObject) {
        for block in arrayOfBlocks {
            CancelableDispatch.cancelDelay(block)
            
        }
    }

}

