//
//  ReacPhoneView.swift
//  humanPhone
//
//  Created by Shohei Yokoyama on 2015/07/27.
//  Copyright (c) 2015年 shohei. All rights reserved.
//

import UIKit

protocol ReacPhoneViewDelegate {
    func tappedView()
}

typealias AnimationCompletionHandler = (animation: Bool) -> Void

class ReacPhoneView: UIView {
    
    var imageView: UIImageView
    var statusView: UIProgressView
    var nonRob: Bool
    var beforeImage: UIImage
    var reactImage: UIImage
    var sleepImage: UIImage
    var helloImage: UIImage
    var tapImage: UIImage
    var delegate: ReacPhoneViewDelegate?
    
    override init (frame: CGRect) {
        imageView = UIImageView()
        statusView = UIProgressView()
        nonRob = Bool()
        beforeImage = UIImage()
        reactImage = UIImage()
        sleepImage = UIImage()
        helloImage = UIImage()
        tapImage = UIImage()
        
        super.init(frame: frame)
        
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        self.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapAction:")
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(statusView)
    }
    
    convenience init (frame: CGRect, nonRobot: Bool) {
        
        self.init(frame: frame)
        
        nonRob = nonRobot
        beforeImage = nonRob ? UIImage(named: "nomal")! : UIImage(named: "robo_nomal")!
        reactImage = nonRob ? UIImage(named: "shock")! : UIImage(named: "robo_shock")!
        sleepImage = nonRob ? UIImage(named: "sleep")! : UIImage(named: "robo_sleep")!
        helloImage = nonRob ? UIImage(named: "hello")! : UIImage(named: "robo_hello")!
        tapImage = nonRob ? UIImage(named: "tap")! : UIImage(named: "robo_hello")!
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var statusFrame: CGRect = statusView.frame
        statusFrame.size.width = CGRectGetWidth(self.bounds) - 100.0
        statusFrame.origin.x = CGRectGetHeight(self.bounds) - 30.0
        statusFrame.origin.y = (CGRectGetWidth(self.bounds) - statusView.frame.size.width) / 2
        statusView.frame = statusFrame
    }
    
    func toggleImage(completionHandler: AnimationCompletionHandler) {
        imageAnimation(reactImage, animationScale: 1.3, completionHandler: completionHandler)
    }
    
    func toggleSleepImage() {
        imageView.image = sleepImage
    }
    
    func toggleTapImage(completionHandler: AnimationCompletionHandler) {
        imageAnimation(tapImage, animationScale: 1.3, completionHandler: completionHandler)
    }
    
    func toggleHelloImage(completionHandler: AnimationCompletionHandler) {
        imageAnimation(helloImage, animationScale: 1.3, completionHandler: completionHandler)
    }
    
    func imageAnimation(image: UIImage, animationScale: CGFloat, completionHandler: AnimationCompletionHandler) {
        imageView.image = image
        UIView.animateWithDuration(0.5,
            delay: 0.0,
            options: UIViewAnimationOptions.CurveLinear,
            animations: { () -> Void in
                self.imageView.transform = CGAffineTransformMakeScale(animationScale, animationScale)
                self.imageView.transform = CGAffineTransformIdentity
            }) { (Bool) -> Void in
                completionHandler(animation: false)
        }
    }
    
    //MARK: TapAction
    func viewTapAction (gestureRecognizer: UITapGestureRecognizer) {
        delegate!.tappedView()
    }
    
}
