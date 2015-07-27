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

    private let homeView: HomeView
    init () {
        homeView = HomeView(frame: UIScreen.mainScreen().bounds)
        
        super.init(nibName: nil, bundle: nil)
        
        homeView.bannerView.rootViewController = self
        homeView.bannerView.loadRequest(GADRequest())
        self.view.addSubview(homeView)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callbackFromTopView()
    }

    func callbackFromTopView() {
        homeView.tappedButton = { (text: NSString) -> Void in
            let con = ReactionViewController(man: true, name: text as String)
            let nav = UINavigationController(rootViewController: con)
            nav.navigationBar.backgroundColor = UIColor.yellowColor()
            nav.navigationBar.tintColor = UIColor.lightGrayColor()
            self.presentViewController(nav, animated: true, completion: nil)
        }
        
        homeView.tappedRobotButton = { () -> Void in
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
