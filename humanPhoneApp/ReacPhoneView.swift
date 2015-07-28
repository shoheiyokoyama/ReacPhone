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

class ReacPhoneView: UIView {

    internal var imageView: UIImageView
    internal var statusView: UIProgressView
    var nonRob: Bool
    internal var beforeImage: UIImage
    internal var reactImage: UIImage
    private var sleepImage: UIImage
    private var helloImage: UIImage
    private var tapImage: UIImage
    var delegate: ReacPhoneViewDelegate?
    
    init (frame: CGRect, nonRobot: Bool) {
        imageView = UIImageView()
        statusView = UIProgressView()
        nonRob = Bool()
        beforeImage = UIImage()
        reactImage = UIImage()
        sleepImage = UIImage()
        helloImage = UIImage()
        tapImage = UIImage()
        
        super.init(frame: frame)
        
        nonRob = nonRobot
        
        if nonRob {
            beforeImage = UIImage(named: "nomal")!
            reactImage = UIImage(named: "shock")!
            sleepImage = UIImage(named: "sleep")!
            helloImage = UIImage(named: "hello")!
            tapImage = UIImage(named: "tap")!
        } else {
            beforeImage = UIImage(named: "robo_nomal")!
            reactImage = UIImage(named: "robo_shock")!
            sleepImage = UIImage(named: "robo_sleep")!
            helloImage = UIImage(named: "robo_hello")!
            tapImage = UIImage(named: "robo_hello")!
        }
        
        imageView.frame = self.bounds
        self.addSubview(imageView)
        
        self.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapAction:")
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(statusView)
        
        
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
    
    func viewTapAction (gestureRecognizer: UITapGestureRecognizer) {
        delegate!.tappedView()
    }

}
