//
//  ASTimer.swift
//  Pods
//
//  Created by Andrew Sowers on 1/14/16.
//
//

import UIKit

public class ASTimer: NSObject {
  
  //mark - instance variables
  var timerName: String = String()
  var expirationTime: NSTimeInterval = 0
  
  // you must define these
  var completionBlock: (() -> Void)?
  var timerStartTime: NSDate?
  var intervalTimer: NSTimer?
  
  //mark methods
  
  public override init() {
    super.init()
    self.intervalTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkExpiration", userInfo: nil, repeats: true)
  }
  
  public init(interval:NSTimeInterval) {
    super.init()
    self.intervalTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "checkExpiration", userInfo: nil, repeats: true)
  }
  
  public init(interval:NSTimeInterval, target:AnyObject, selector:Selector, userInfo:AnyObject, repeats:Bool) {
    super.init()
    self.intervalTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: target, selector: selector, userInfo: userInfo, repeats: repeats)
    
  }
  // build a new timer
  public func timer(name:String, expirationTime:NSTimeInterval, completionBlock: (() -> Void)?) -> ASTimer {
    let timer = ASTimer()
    timer.timerName = name
    timer.expirationTime = expirationTime
    timer.completionBlock = completionBlock
    return timer
  }
    
  func checkExpiration() -> Void {
    print("Checking expiration time")
    if let startTime:NSDate = timerStartTime {
      let currentDate = NSDate()
      let timePassed: NSTimeInterval = currentDate.timeIntervalSinceDate(startTime)
      print("time passed: \(timePassed) with an expiration time of: \(self.expirationTime)")
      if timePassed > self.expirationTime {
        self.invalidateTimer()
        if let block = completionBlock{
          block()
        }
      }
    }
  }
  
  public func fireTimer() -> Void {
    self.timerStartTime = self.timerStartTime != nil ? self.timerStartTime : NSDate()
    self.intervalTimer?.fire()
  }
  
  public func invalidateTimer() -> Void {
    self.intervalTimer?.invalidate()
    self.intervalTimer = nil
  }
  
  deinit {
    print("\(self.timerName) is being deinitialized")
    self.invalidateTimer()
  }
  
}
