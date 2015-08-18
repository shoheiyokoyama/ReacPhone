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
    var userName: NSString?
    var reacPhoneView: ReacPhoneView
    var active: Bool
    var idling: Bool
    var animation: Bool
    var callSleepAction: Bool
    var instance: AudioTool?
    var manager: CMMotionManager?
    var nowDate: NSDate
    var morningDate: NSDate
    var afternoonDate: NSDate
    var nightDate: NSDate
    
    init (nonRobot: Bool) {
        nonRob = Bool()
        userName = NSString()
        active = Bool()
        idling = Bool()
        animation = Bool()
        callSleepAction = Bool()
        nowDate = NSDate()
        morningDate = NSDate()
        afternoonDate = NSDate()
        nightDate = NSDate()
        reacPhoneView = ReacPhoneView(frame: UIScreen.mainScreen().bounds, nonRobot: nonRobot)

        super.init(nibName: nil, bundle: nil)
        
        nonRob = nonRobot
        reacPhoneView.delegate = self
        reacPhoneView.statusView.progress = 1.0
        reacPhoneView.statusView.tintColor = UIColor(red: 0.27, green: 0.85, blue: 0.46, alpha: 1.0)
        self.view.addSubview(reacPhoneView)
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        var dateStr: String = formatter.stringFromDate(nowDate)
        var morning: String = dateStr + "05:00:00"
        var afternoon: String = dateStr + "12:00:00"
        var night: String = dateStr + "17:00:00"
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        morningDate = dateFormatter.dateFromString(morning)!
        afternoonDate = dateFormatter.dateFromString(afternoon)!
        nightDate = dateFormatter.dateFromString(night)!
        
        NSLog(dateFormatter.stringFromDate(nowDate))
        
    }
    
    convenience init (nonRobot: Bool, name: NSString)
    {
        self.init(nonRobot: nonRobot)
        userName = name
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func audioInstance() -> AudioTool {
        return AudioTool.sharedInstance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "閉じる", style: .Plain, target: self, action: "onClickMyButton:")
        var notification: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        notification.addObserver(
            self,
            selector: "didEnterBackground:",
            name:UIApplicationDidBecomeActiveNotification,
            object: nil)
        reacPhoneView.imageView.image = reacPhoneView.beforeImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedView() {
    }

}
