//
//  TopView.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/21.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TopView: UIView, UITextFieldDelegate {
    private var logoImageView: UIImageView
    private let textField: UITextField
    internal var bannerView: GADBannerView
    
    override init (frame: CGRect) {
        logoImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 300.0, 70.0))
        textField = UITextField(frame: CGRectMake(0.0, 0.0, 200.0, 30))
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        super.init(frame:frame)
        
        self.backgroundColor = UIColor(red: 255/255.0, green:240/255.0, blue:70/255.0, alpha: 1.0)
        
        logoImageView.image = UIImage(named: "logo")
        self.addSubview(logoImageView)
        
        bannerView.adUnitID = "ca-app-pub-9398695746908582/1848241756"
        self.addSubview(bannerView)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    super.layoutSubviews()
        
        var logoFrame: CGRect = logoImageView.frame
        logoFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(logoImageView.frame)) / 2;
        logoFrame.origin.y = (CGRectGetHeight(self.bounds) / 2) - 170.0
        logoImageView.frame = logoFrame
        
//        var buttonFrame: CGRect = 
    }
    

}
