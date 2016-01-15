//
//  ASTimer.swift
//  Pods
//
//  Created by Andrew Sowers on 1/14/16.
//
//

import UIKit

class ASTimer: NSObject {
  
  
  //mark - instance variables
  var timerName: String = String()
  var expirationTime: Int = 0
  
  // you must define these
  var completionBlock: (() -> Void)?
  var timerStartTime: NSDate?
  var intervalTimer: NSTimer?
  
  //mark methods
  
  override init() {
    super.init()
    self.intervalTimer = NSTimer(timeInterval: 1.0, target: self, selector: "checkExpiration", userInfo: nil, repeats: true)

  }
  // build a new timer
  func timer(name:String, expirationTime:Int, completionBlock: (() -> Void)?) -> ASTimer {
    let timer = ASTimer()
    timer.timerName = name
    timer.expirationTime = expirationTime
    timer.completionBlock = completionBlock
    return timer
  }
    
  func checkExpiration() -> Void {
    if let startTime:NSDate = timerStartTime {
      let currentDate = NSDate()
      let timePassed: Int = Int(currentDate.timeIntervalSinceDate(startTime))
      if timePassed > self.expirationTime {
        self.invalidateTimer()
        if let block = completionBlock{
          block()
        }
      }
    }
  }
  
  func fireTimer() -> Void {
    self.timerStartTime = self.timerStartTime != nil ? self.timerStartTime : NSDate()
  }
  
  func invalidateTimer() -> Void {
    self.intervalTimer?.invalidate()
  }
  
  deinit {
    self.invalidateTimer()
  }
  
}
