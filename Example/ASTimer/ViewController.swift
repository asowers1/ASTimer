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
  
  @IBOutlet weak var timeRemainingLabel: UILabel!
  @IBOutlet weak var countdownFinishedImageView: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let now = NSDate()
    let timeInterval: NSTimeInterval = 10 // ten seconds
    
    let secondslater = now.dateByAddingTimeInterval(timeInterval) // some seconds as a time intrval
    
    let images = self.animationsImages()
    
    self.countdownFinishedImageView.animationImages = images
    self.countdownFinishedImageView.animationDuration = 1
    
    asTimer = ASTimer().timer("Test Timer", expirationTime: secondslater.timeIntervalSinceDate(now), completionBlock: {(Void) -> (Void) in
      
      self.countdownFinishedImageView.startAnimating()
      self.timeRemainingLabel.text = "Happy New Year!"
      print("Hey, it's been \(timeInterval) seconds! Happy New Year!")
      
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
  
  // load some images for our example animation that occurs when the timer completion closure is executed
  func animationsImages() -> [UIImage] {
    var images = [UIImage]()
    for index in 0 ... 66 {
      images.insert(UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource("sparkler_\(index)",ofType:"png")!)!, atIndex: index)
    }
    return images
  }
  
  
  func timerDidFire(timerName: String?, timeRemaining: NSTimeInterval) {
    self.timeRemainingLabel.text = "\(round(timeRemaining)) seconds!"
    print("the timer \(timerName as String!) has \(round(timeRemaining)) seconds left")
  }
  
}

