//
//  ViewController.swift
//  ASTimer
//
//  Created by asowers1 on 01/14/2016.
//  Copyright (c) 2016 asowers1. All rights reserved.
//

import UIKit
import ASTimer

class ViewController: UIViewController {
  
  var asTimer:ASTimer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let now = NSDate()
    let timeInterval: NSTimeInterval = 60*1
    let secondslater = now.dateByAddingTimeInterval(timeInterval) // some seconds as a time intrval
    
    asTimer = ASTimer().timer("Test Timer", expirationTime: secondslater.timeIntervalSinceDate(now), completionBlock: {(Void) -> (Void) in
      print("Hey, it's been \(timeInterval/60) seconds")
    })
    
    asTimer?.fireTimer() // we need to fire the timer to start it
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)

  }
  
  
  
}

