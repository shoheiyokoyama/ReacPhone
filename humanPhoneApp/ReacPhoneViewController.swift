//
//  ReacPhoneViewController.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/27.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit
import CoreMotion

class ReacPhoneViewController: UIViewController, ReacPhoneViewDelegate {

    var nonRob: Bool?
    var userName: String?
    var reacPhoneView: ReacPhoneView
    var active: Bool
    var idling: Bool
    var animation: Bool
    var callSleepAction: Bool
//    let audioInstance: AudioTool?
    var manager: CMMotionManager?
    var nowDate: NSDate
    var morningDate: NSDate
    var afternoonDate: NSDate
    var nightDate: NSDate
    var timer:NSTimer
    
    init (nonRobot: Bool) {
        nonRob = Bool()
        userName = String()
        active = Bool()
        idling = Bool()
        animation = Bool()
        callSleepAction = Bool()
        nowDate = NSDate()
        morningDate = NSDate()
        afternoonDate = NSDate()
        nightDate = NSDate()
        reacPhoneView = ReacPhoneView(frame: UIScreen.mainScreen().bounds, nonRobot: nonRobot)
        timer = NSTimer()

        super.init(nibName: nil, bundle: nil)
        
        nonRob = nonRobot
        reacPhoneView.delegate = self
        reacPhoneView.statusView.progress = 1.0
        reacPhoneView.statusView.tintColor = UIColor(red: 0.27, green: 0.85, blue: 0.46, alpha: 1.0)
        self.view.addSubview(reacPhoneView)
    }
    
    convenience init (nonRobot: Bool, name: String)
    {
        self.init(nonRobot: nonRobot)
        userName = name
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "YYYY/MM/dd"
        var dateStr: String = formatter.stringFromDate(nowDate)
        NSLog(dateStr)
        var morning: String = "\(dateStr) 05:00:00"
        var afternoon: String = "\(dateStr) 12:00:00"
        var night: String = "\(dateStr) 17:00:00"
         NSLog(morning)
         NSLog(afternoon)
         NSLog(night)
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        morningDate = dateFormatter.dateFromString(morning)!
        afternoonDate = dateFormatter.dateFromString(afternoon)!
        nightDate = dateFormatter.dateFromString(night)!
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func audioinstance() -> AudioTool {
        return AudioTool.sharedInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: .Plain, target: self, action: "onClickCloseButton:")
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(
            self,
            selector: "didEnterBackground:",
            name:UIApplicationDidEnterBackgroundNotification,
            object: nil)
        reacPhoneView.imageView.image = reacPhoneView.beforeImage
    }
    
    

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        reacPhoneView.statusView.progress = nonRob! ? userDefaults.floatForKey("status") : userDefaults.floatForKey("roboStatus")
        
        self.progressChangeValue(0.0)
        
        if reacPhoneView.statusView.progress == 0 {
            reacPhoneView.imageView.image = reacPhoneView.reactImage
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !(reacPhoneView.statusView.progress == 0.0) {
            animation = true
            reacPhoneView.toggleHelloImage({ (animation: Bool) -> Void in
                self.animation = animation
            })
        }
        nonRob! ? self.sayGreeting() : self.audioinstance().playSoundFile("")
        self.getDiviceMotionData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        manager?.stopDeviceMotionUpdates()
        active = true
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        nonRob! ? userDefault.setFloat(reacPhoneView.statusView.progress, forKey: "status") : userDefault.setFloat(reacPhoneView.statusView.progress, forKey: "roboStatus")
        userDefault.synchronize()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func onClickCloseButton(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getDiviceMotionData() {
        manager = CMMotionManager()
        if manager!.deviceMotionAvailable {
            manager!.deviceMotionUpdateInterval = 1.0 / 10.0
        }
        let handler: CMDeviceMotionHandler = {(motion: CMDeviceMotion!, error: NSError!) -> Void in
            if (motion.rotationRate.x > 3.5 || motion.rotationRate.x < -3.5) && !self.animation {
                self.progressChangeValue(-0.1)
                self.reacPhoneView.toggleImage({ (animation: Bool) -> Void in
                    self.animation = animation
                })
                self.cancelSleepAction()
                self.animation = true
                self.active = true
                self.idling = false
                self.callSleepAction = false
                self.nonRob! ? self.audioinstance().speak("痛い", rate: 0.2, pitchMultiplier: 1.2) : self.audioinstance().playSoundFile("robo_shock.mp3")
            } else if (motion.rotationRate.y > 3.0 || motion.rotationRate.y < -3.0) && !self.animation {
                self.progressChangeValue(-0.1)
                self.reacPhoneView.toggleImage({ (animation: Bool) -> Void in
                    self.animation = animation
                })
                self.cancelSleepAction()
                self.animation = true
                self.active = true
                self.idling = false
                self.callSleepAction = false
                self.nonRob! ? self.audioinstance().speak("いてえよ", rate: 0.2, pitchMultiplier: 0.6) : self.audioinstance().playSoundFile("robo_shock.mp3")
            } else if (motion.rotationRate.z > 3.5 || motion.rotationRate.z < -3.5) && self.animation {
                self.progressChangeValue(-0.1)
                self.reacPhoneView.toggleImage({ (animation: Bool) -> Void in
                    self.animation = animation
                })
                self.cancelSleepAction()
                self.animation = true
                self.active = true
                self.idling = false
                self.callSleepAction = false
                self.nonRob! ? self.audioinstance().speak("うわわわ", rate: 0.2, pitchMultiplier: 0.6) : self.audioinstance().playSoundFile("robo_shock.mp3")
            } else {
                if !self.idling && !self.animation {
                    self.reacPhoneView.imageView.image = self.reacPhoneView.beforeImage
                }
                if !self.callSleepAction {
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("sleepAction"), userInfo: nil, repeats: false)
                    self.callSleepAction = true
                    self.active = false
                }
            }
        }
        
        manager?.startDeviceMotionUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: handler)
    }
    
    func tappedView() {
        idling = false
        active = true
        
        if !animation {
            animation = true
            nonRob! ? self.audioinstance().speakRandom(0.3, pitchMultiplier: 0.7) : self.audioinstance().playSoundFile("robo_tap.wav")
            reacPhoneView.toggleTapImage({ (animation: Bool) -> Void in
                self.animation = animation
            })
        }
    }
    
    func cancelSleepAction() {
        self.timer.invalidate()
    }
    
    func progressChangeValue(value: Float) {
        reacPhoneView.statusView.progress += value
        
        if reacPhoneView.statusView.progress == 0 {
            nonRob! ? self.audioinstance().speak("もっと大切に扱って下さい", rate: 0.2, pitchMultiplier: 0.5) : self.audioinstance().playSoundFile("robo_init.mp3")
            manager!.stopDeviceMotionUpdates()
        } else if reacPhoneView.statusView.progress < 0.2 {
            reacPhoneView.statusView.tintColor = UIColor.redColor()
        } else if reacPhoneView.statusView.progress < 0.4 {
            reacPhoneView.statusView.tintColor = UIColor.yellowColor()
        } else {
            reacPhoneView.statusView.tintColor = UIColor(red: 0.27, green:0.85, blue:0.46, alpha: 1.0)
        }
    }
    
    func sayGreeting() {
        if nowDate.compare(morningDate) == NSComparisonResult.OrderedDescending && nowDate.compare(afternoonDate) == NSComparisonResult.OrderedAscending {
            var greet: String = userName! + "さん おはよう"
            self.audioinstance().speak(greet, rate: 0.1, pitchMultiplier: 0.5)
        } else if nowDate.compare(afternoonDate) == NSComparisonResult.OrderedDescending && nowDate.compare(nightDate) == NSComparisonResult.OrderedAscending {
            var greet : String = userName! + "さん こんにちは"
            self.audioinstance().speak(greet, rate: 0.1, pitchMultiplier: 0.5)
        } else {
            var greet : String = userName! + "さん こんばんわ"
            self.audioinstance().speak(greet, rate: 0.1, pitchMultiplier: 0.5)
        }
    }
    
    func didEnterBackground(nitification: NSNotification) {
        reacPhoneView.toggleSleepImage()
    }
    
    func sleepAction() {
        if !active {
            reacPhoneView.toggleSleepImage()
            self.audioinstance().speak("goo", rate: 0.1, pitchMultiplier: 0.2)
            idling = true
            self.progressChangeValue(0.1)
        }
        callSleepAction = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
