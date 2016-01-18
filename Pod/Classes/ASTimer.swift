//
//  ASTimer.swift
//  Pods
//
//  Created by Andrew Sowers on 1/14/16.
//
//

import UIKit

public protocol ASTimerDelegate {
  func timerDidFire(timerName:String?, timeRemaining: NSTimeInterval)
}

public class ASTimer: NSObject {
  
  //MARK: private instance variables
  var timerName: String? = String()
  var timerInterval: NSTimeInterval = 1
  var expirationTime: NSTimeInterval = 0
  var intervalTimer: NSTimer?
  var activeNotificationIdentifiers = [String]()
  var completionBlock: (() -> Void)?
  
  //Mark: public instance variables
  public var debugMode = false
  public var delegate: ASTimerDelegate?
  public var timerStartTime: NSDate?
  
  //MARK: methods
  
  //builds a new timer
  public func timer(name:String, expirationTime:NSTimeInterval, completionBlock: (() -> Void)?) -> ASTimer {
    let timer = ASTimer()
    timer.timerName = name
    timer.expirationTime = expirationTime
    timer.completionBlock = completionBlock
    timer.intervalTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "checkExpiration", userInfo: nil, repeats: true)
    return timer
  }
  
  //MARK: notifications
  
  public func observeStartNotifications(notifications:[String]) -> Void {
    for notification:String in notifications {
      if let unwrappedNotification:String = notification {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetTimer", name: unwrappedNotification, object: nil)
      }
    }
  }
  
  public func observeStartNotification(notification:String) -> Void {
    self.observeStartNotifications([notification])
  }
  
  public func observeStopNotifications(notifications:[String]) -> Void {
    for notification:String in notifications {
      if let unwrappedNotification:String = notification {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "invalidateTimer", name: unwrappedNotification, object: nil)
      }
    }
  }
  
  public func observeStopNotification(notification:String) -> Void {
    self.observeStopNotifications([notification])
  }
  
  //MARK: timer functions
  
  func checkExpiration() -> Void {
    if let startTime:NSDate = timerStartTime {
      let currentDate = NSDate()
      let timePassed: NSTimeInterval = currentDate.timeIntervalSinceDate(startTime)
      if debugMode {
        print("time passed: \(timePassed) with an expiration time of: \(self.expirationTime)")
      }
      if timePassed > self.expirationTime {
        self.invalidateTimer()
        if let block = completionBlock{
          block()
        }
      } else {
        self.delegate?.timerDidFire(self.timerName, timeRemaining: self.expirationTime - timePassed)
      }
    }
  }
  
  public func fireTimer() -> Void {
    self.timerStartTime = self.timerStartTime != nil ? self.timerStartTime : NSDate()
    self.intervalTimer?.fire()
  }
  
  // this will reset your timer
  func resetTimer() -> Void {
    self.invalidateTimer()
    self.intervalTimer = NSTimer.scheduledTimerWithTimeInterval(self.timerInterval, target: self, selector: "checkExpiration", userInfo: nil, repeats: true)
  }
  
  // this will invalidate your timer and halt its ticking
  public func invalidateTimer() -> Void {
    self.intervalTimer?.invalidate()
    self.intervalTimer = nil
  }
  
  // cleanup
  deinit {
    if self.debugMode {
      print("\(self.timerName) is being deinitialized")
    }
    self.invalidateTimer()
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
}
