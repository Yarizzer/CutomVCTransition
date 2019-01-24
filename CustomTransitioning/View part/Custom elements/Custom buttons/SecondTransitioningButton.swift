//
//  SecondTransitioningButton.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 24/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SecondTransitioningButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        animateButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        animateButton()
    }
    
    func setupView() {
        self.frame = CGRect(origin: .zero, size: CGSize(width: Constants.width, height: Constants.height))
        
        self.layer.cornerRadius = frame.height / 2
        self.layer.masksToBounds = true
        
        self.layer.borderColor = Constants.borderColor.cgColor
        self.layer.borderWidth = Constants.borderWidth
    }
    
    private func animateButton() {
        let backgroundColorAnimation = CAKeyframeAnimation(keyPath: Constants.backgroundColorAnimationKeyPath)
        backgroundColorAnimation.duration = Constants.animationDuration
        backgroundColorAnimation.values = [Constants.clearColor.cgColor,
                                           Constants.clearColor.cgColor,
                                           Constants.greenColor.cgColor,
                                           Constants.clearColor.cgColor,
                                           Constants.clearColor.cgColor]
        backgroundColorAnimation.keyTimes = Constants.keyTimes
        backgroundColorAnimation.timingFunctions = Constants.timingFunctions
        backgroundColorAnimation.repeatCount = Constants.repeatCount
        backgroundColorAnimation.beginTime = Constants.startMoment
        backgroundColorAnimation.isRemovedOnCompletion = Constants.removedOnCompletionFlag
        self.layer.add(backgroundColorAnimation, forKey: Constants.backgroundColorAnimationKeyPath)
        
        
        let rotationTransformForTitle = CATransform3DMakeRotation(Constants.rotationAngle, 1, 0, 0)
        self.titleLabel?.layer.transform = rotationTransformForTitle
        
        let titleRotationAnimation = CAKeyframeAnimation(keyPath: Constants.titleRotationAnimationKeyPath)
        titleRotationAnimation.duration = Constants.animationDuration
        
        titleRotationAnimation.values = Constants.titleRotationValues
        titleRotationAnimation.keyTimes = Constants.titleRotationKeyTimes
        
        titleRotationAnimation.timingFunctions = Constants.timingFunctions
        titleRotationAnimation.repeatCount = Constants.repeatCount
        titleRotationAnimation.beginTime = Constants.startMoment
        titleRotationAnimation.isRemovedOnCompletion = Constants.removedOnCompletionFlag
        self.titleLabel?.layer.add(titleRotationAnimation, forKey: Constants.titleRotationAnimationKeyPath)
    }
}

extension SecondTransitioningButton {
    private struct Constants {
        //-----Frame section-----
        static let width: CGFloat = 100.0
        static let height: CGFloat = 50.0
        //-----Start layer section-----
        static let borderColor = UIColor.green
        static let borderWidth: CGFloat = 1.0
        
        //-----End layer section-----
        //-----Start animation section-----
        //-------Common properties-------
        static let startMoment: Double = 0
        static let animationDuration: Double = 10
        static let timingFunctions = [CAMediaTimingFunction(name: .linear)]
        static let repeatCount: Float = HUGE
        //-------Background color animation-------
        static let backgroundColorAnimationKeyPath = "backgroundColor"
        static let clearColor = UIColor.clear
        static let greenColor = UIColor.green
        static let keyTimes: [NSNumber] = [0.000, 0.500, 0.650, 0.800, 1.000]
        static let removedOnCompletionFlag = false
        //-------Title rotation animation-------
        static let rotationAngle = CGFloat(90 * Double.pi / 180)
        static let titleRotationAnimationKeyPath = "transform.rotation.x"
        static let titleRotationValues: [Float] = [0.000, 0.000, -1.571, -1.571, 0.000, 0.300, 0.000]
        static let titleRotationKeyTimes: [NSNumber] = [0.000, 0.400, 0.500, 0.800, 0.950, 0.985, 1.000]
        
    }
}
