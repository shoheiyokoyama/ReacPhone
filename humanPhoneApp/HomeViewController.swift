//
//  HomeViewController.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/26.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HomeViewController: UIViewController {

    private let topView: TopView
    init () {
        topView = TopView(frame: UIScreen.mainScreen().bounds)
        
        super.init(nibName: nil, bundle: nil)
        
        topView.bannerView.rootViewController = self
        topView.bannerView.loadRequest(GADRequest())
        self.view.addSubview(topView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topView.tappedButton = { (text: NSString) -> Void in
            let con = ReactionViewController(man: true, name: text as String)
            let nav = UINavigationController(rootViewController: con)
            nav.navigationBar.backgroundColor = UIColor.yellowColor()
            nav.navigationBar.tintColor = UIColor.lightGrayColor()
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
        topView.tappedRobotButton = { () -> Void in
            let con = ReactionViewController(man: false)
            let nav = UINavigationController(rootViewController: con)
            nav.navigationBar.backgroundColor = UIColor.yellowColor()
            nav.navigationBar.tintColor = UIColor.lightGrayColor()
            self.presentViewController(nav, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
