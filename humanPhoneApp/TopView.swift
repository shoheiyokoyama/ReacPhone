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
    internal let textField: UITextField
    internal var bannerView: GADBannerView
    private var startButton: UIButton
    private var startRobotButton: UIButton
    internal var tappedButton:((NSString) -> ())?
    internal var tappedRobotButton:(() -> ())?
    
    override init (frame: CGRect) {
        logoImageView = UIImageView(frame: CGRectMake(0.0, 0.0, 300.0, 70.0))
        textField = UITextField(frame: CGRectMake(0.0, 0.0, 200.0, 30))
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        startButton = UIButton(frame: CGRectMake(0.0, 0.0, 200.0, 40.0))
        startRobotButton = UIButton(frame: CGRectMake(0.0, 0.0, 200.0, 40.0))
        
        super.init(frame:frame)
        
        self.backgroundColor = UIColor(red: 255/255.0, green:240/255.0, blue:70/255.0, alpha: 1.0)
        
        logoImageView.image = UIImage(named: "logo")
        self.addSubview(logoImageView)
        
        startButton.setTitle("START", forState: .Normal)
        startButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Regular", size: 18.0)
        startButton.contentEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
        startButton.backgroundColor = UIColor.yellowColor()
        startButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startButton.layer.cornerRadius = 5.0
        startButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        startButton.userInteractionEnabled = true
        let buttonTap = UITapGestureRecognizer(target: self, action: "tapStartButton:")
        startButton.addGestureRecognizer(buttonTap)
        self.addSubview(startButton)
        
        startRobotButton.setTitle("START ROBOT", forState: .Normal)
        startRobotButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Regular", size: 18.0)
        startRobotButton.contentEdgeInsets = UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
        startRobotButton.backgroundColor = UIColor.yellowColor()
        startRobotButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        startRobotButton.layer.cornerRadius = 5.0
        startRobotButton.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        startRobotButton.userInteractionEnabled = true
        let robotbuttonTap = UITapGestureRecognizer(target: self, action: "tapRobotButton:")
        startRobotButton.addGestureRecognizer(robotbuttonTap)
        self.addSubview(startRobotButton)
        
        bannerView.adUnitID = "ca-app-pub-9398695746908582/1848241756"
        self.addSubview(bannerView)
        
        textField.placeholder = "What's your name?"
        textField.textAlignment = NSTextAlignment.Left
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.font = UIFont(name: "ChalkboardSE-Regular", size: 14.0)
//        textField.keyboardType = UIKeyboardAppearance.Default
        textField.clearButtonMode = UITextFieldViewMode.Never
        textField.delegate = self
        self.addSubview(textField)
        
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
        
        var startButtonFrame: CGRect = startRobotButton.frame
        startButtonFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(startButton.frame)) / 2
        startButtonFrame.origin.y = CGRectGetHeight(self.bounds) - 190.0
        startButton.frame = startButtonFrame
        
        var robotButtonFrame: CGRect = startRobotButton.frame
        startButtonFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(startRobotButton.frame)) / 2
        startButtonFrame.origin.y = CGRectGetHeight(self.bounds) - 120.0
        startRobotButton.frame = startButtonFrame
        
        var bannerFrame: CGRect = bannerView.frame
        bannerFrame.origin.x = CGRectGetWidth(self.bounds) - bannerView.frame.size.height
        bannerView.frame = bannerFrame
        
        var textFrame: CGRect = textField.frame
        startButtonFrame.origin.x = (CGRectGetWidth(self.bounds) - CGRectGetWidth(textField.frame)) / 2
        startButtonFrame.origin.y = CGRectGetMaxY(logoImageView.frame) + 50.0
        textField.frame = startButtonFrame
        
    }
    
    func tapStartButton (gestureRecognizer: UITapGestureRecognizer) {
        
        tappedButton!(textField.text)
    }
    
    func tapRobotButton (gestureRecognizer: UITapGestureRecognizer) {
        tappedRobotButton!()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

//class RTButton: UIButton {
//    
//    override func setTitleColor(color: UIColor?, forState state: UIControlState) {
//        
//        var baseColor: UIColor = UIColor.yellowColor()
//        self.backgroundColor = colorWithBrightnessFactor(baseColor: UIColor, 1.0: CGFloat, saturationRatio: 0.6, brightnessRatio: 1.4)
//        
//    }
//    
//    func colorWithBrightnessFactor(baseColor: UIColor, hueRatio: CGFloat, saturationRatio: CGFloat, brightnessRatio: CGFloat) -> (UIColor) {
//        var hue: CGFloat = 0;
//        var saturation: CGFloat = 0;
//        var brightness = 0;
//        var alpha: CGFloat = 0;
//        
//        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
//            return UIColor(hue: hue * hueRatio, saturation: saturation * saturationRatio, brightness: brightness * saturationRatio, alpha: alpha)
//        }
//        return self;
//    }
//}