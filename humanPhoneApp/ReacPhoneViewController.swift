//
//  ReacPhoneViewController.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/27.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit

class ReacPhoneViewController: UIViewController, ReacPhoneViewDelegate {

    private var nonRob: Bool?
    private var userName: NSString?
    private let reacPhoneView: ReacPhoneView
    
    init (nonRobot: Bool, name: NSString)
    {
        reacPhoneView = ReacPhoneView(frame: UIScreen.mainScreen().bounds, nonRobot: nonRobot)
        
        super.init(nibName: nil, bundle: nil)
        nonRob = nonRobot
        userName = name
        reacPhoneView.delegate = self
        
        self.view.addSubview(reacPhoneView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reacPhoneView.imageView.image = reacPhoneView.beforeImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedView() {
        AudioTool
    }

}
