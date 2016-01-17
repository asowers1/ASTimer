//
//  ViewController.swift
//  ASTimer
//
//  Created by asowers1 on 01/14/2016.
//  Copyright (c) 2016 asowers1. All rights reserved.
//

import UIKit
import ASTimer

class ViewController: UIViewController, ASTimerDelegate {
  
  var asTimer:ASTimer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let now = NSDate()
    let timeInterval: NSTimeInterval = 60*1
    let secondslater = now.dateByAddingTimeInterval(timeInterval) // some seconds as a time intrval
    
    asTimer = ASTimer().timer("Test Timer", expirationTime: secondslater.timeIntervalSinceDate(now), completionBlock: {(Void) -> (Void) in
      print("Hey, it's been \(timeInterval/60) seconds")
    })
    
    // we can listen for timer ticks via the delegate
    asTimer?.delegate = self
    
//    Some Example notifications to listen for:
//    
//    UIApplicationBackgroundRefreshStatusDidChangeNotification
//    UIApplicationDidBecomeActiveNotification
//    UIApplicationDidChangeStatusBarFrameNotification
//    UIApplicationDidChangeStatusBarOrientationNotification
//    UIApplicationDidEnterBackgroundNotification
//    UIApplicationDidFinishLaunchingNotification
//    UIApplicationDidReceiveMemoryWarningNotification
//    UIApplicationProtectedDataDidBecomeAvailable
//    UIApplicationProtectedDataWillBecomeUnavailable
//    UIApplicationSignificantTimeChangeNotification
//    UIApplicationUserDidTakeScreenshotNotification
//    UIApplicationWillChangeStatusBarOrientationNotification
//    UIApplicationWillChangeStatusBarFrameNotification
//    UIApplicationWillEnterForegroundNotification
//    UIApplicationWillResignActiveNotification
//    UIApplicationWillTerminateNotification
//    UIContentSizeCategoryDidChangeNotification
//    
//    Source: https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIApplication_Class/
    
    // This will always start the timer if it's not already
    asTimer?.observeStartNotification("UIApplicationDidBecomeActiveNotification")
    
    // This will always stop the timer if it's not already
    asTimer?.observeStopNotification("UIApplicationDidEnterBackgroundNotification")
    
    // for debugging purposes
    asTimer?.debugMode = false // false by default
    
    // we fire the timer to start it, but you fire a notification of your choice to do the same thing
    asTimer?.fireTimer()
  
  }
  
  func timerDidFire(timerName: String?, timeRemaining: NSTimeInterval) {
    print("the timer \(timerName as String!) has \(timeRemaining) seconds left")
  }
  
}

