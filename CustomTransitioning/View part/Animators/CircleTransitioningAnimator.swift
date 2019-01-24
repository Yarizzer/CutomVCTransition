//
//  TransitioningAnimator.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 23/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class CircleTransitioningAnimator: NSObject {
    var sender: FirstTransitioningButton
    var isPresenting: Bool

    init(with sender: FirstTransitioningButton, presenting state: Bool) {
        self.sender = sender
        self.isPresenting = state
    }
    
    private func present(withContext context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let destinationVC = context.viewController(forKey: .to), let destinationView = context.view(forKey: .to) else { context.completeTransition(false)
            return }
        
        let finalFrame = context.finalFrame(for: destinationVC)
        
        let transitionStartPoint = sender.center
        
        let circleView = createCircleView(forView: destinationView)
        circleView.center = transitionStartPoint
        circleView.alpha = Constants.minAlfaValue
        containerView.addSubview(circleView)
        
        destinationView.center = transitionStartPoint
        destinationView.alpha = Constants.minAlfaValue
        destinationView.transform = CGAffineTransform(scaleX: Constants.minScaleValue, y: Constants.minScaleValue)
        containerView.addSubview(destinationView)
        
        UIView.animate(withDuration: Constants.transitionDuration, animations: {
            
            destinationView.transform = CGAffineTransform(scaleX: Constants.maxScaleValue, y: Constants.maxScaleValue)
            destinationView.frame = finalFrame
            destinationView.alpha = Constants.maxAlfaValue
            
            circleView.transform = CGAffineTransform(scaleX: Constants.maxScaleValue, y: Constants.maxScaleValue)
            circleView.center = destinationView.center
            circleView.alpha = Constants.maxAlfaValue
        }) { (finished) in
            circleView.removeFromSuperview()
            context.completeTransition(finished)
        }
    }
    
    private func dismiss(withContext context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let dismissedView = context.view(forKey: .from),
            let presentedView = context.view(forKey: .to) else {
                context.completeTransition(false)
                return }
        containerView.insertSubview(presentedView, belowSubview: dismissedView)
        
        let transitionStartPoint = sender.center
        
        let circleView = createCircleView(forView: dismissedView)
        circleView.center = presentedView.center
        circleView.alpha = Constants.maxAlfaValue
        containerView.insertSubview(circleView, belowSubview: dismissedView)
        
        dismissedView.alpha = Constants.maxAlfaValue
        
        UIView.animate(withDuration: Constants.transitionDuration, animations: {
            
            dismissedView.transform = CGAffineTransform(scaleX: Constants.minScaleValue, y: Constants.minScaleValue)
            dismissedView.center = transitionStartPoint
            
            circleView.transform = CGAffineTransform(scaleX: Constants.minScaleValue, y: Constants.minScaleValue)
            circleView.center = transitionStartPoint
            
            circleView.alpha = Constants.minAlfaValue
            
            dismissedView.alpha = Constants.minAlfaValue
        }) { (finished) in
            circleView.removeFromSuperview()
            context.completeTransition(finished)
        }
    }
    
    private func createCircleView(forView view: UIView) -> UIView {
        let d = sqrt(pow(view.bounds.width, 2) + pow(view.bounds.height, 2))
        let circleView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: d, height: d)))
        circleView.layer.cornerRadius = d / 2
        circleView.layer.masksToBounds = true
        circleView.backgroundColor = Constants.circleBackgroundColor
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = circleView.bounds
        blurView.layer.cornerRadius = d / 2
        blurView.layer.masksToBounds = true

        circleView.addSubview(blurView)
        
        if isPresenting {
            circleView.transform = CGAffineTransform(scaleX: Constants.minScaleValue, y: Constants.minScaleValue)
        }
        
        return circleView
    }
}

extension CircleTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            self.present(withContext: transitionContext)
        } else {
            self.dismiss(withContext: transitionContext)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Constants.transitionDuration
    }
}

extension CircleTransitioningAnimator {
    private struct Constants {
        //-----Transitioning properies-----
        static let transitionDuration: Double = 0.5
        static let minScaleValue: CGFloat = 0.05
        static let maxScaleValue: CGFloat = 1.0
        static let minAlfaValue: CGFloat = 0.1
        static let maxAlfaValue: CGFloat = 1
        
        //-----Circle view properties-----
        static let circleBackgroundColor = UIColor.clear
    }
}
