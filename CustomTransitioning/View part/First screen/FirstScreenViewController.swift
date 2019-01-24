//
//  FirstScreenViewController.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 23/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class FirstScreenViewController: UIViewController {

    private var firstButton: FirstTransitioningButton!
    private var secondButton: SecondTransitioningButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        firstButton = FirstTransitioningButton()
        firstButton.center = Constants.firstButtonPoint
        firstButton.setTitle(Constants.firstButtonTitle, for: .normal)
        firstButton.addTarget(self, action: #selector(firstButtonAction), for: .touchUpInside)
        self.view.addSubview(firstButton)
        
        secondButton = SecondTransitioningButton()
        secondButton.center = Constants.secondButtonPoint
        secondButton.setTitle(Constants.secondButtonTitle, for: .normal)
        secondButton.addTarget(self, action: #selector(secondButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(secondButton)
        
        // Do any additional setup after loading the view.
    }
    
    @objc private func firstButtonAction(_ sender: FirstTransitioningButton) {
        performSegue(withIdentifier: Constants.seconsScreenSegueIdentifier, sender: nil)
    }
    
    @objc private func secondButtonAction(_ sender: SecondTransitioningButton) {
        performSegue(withIdentifier: Constants.thirdScreenSegueIdentifier, sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.seconsScreenSegueIdentifier {
            let dvc = segue.destination as! SecondScreenViewController
            dvc.transitioningDelegate = self
        } else if segue.identifier == Constants.thirdScreenSegueIdentifier {
            let dvc = segue.destination as! ThirdScreenViewController
            dvc.transitioningDelegate = self
        }
    }


}

extension FirstScreenViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presented {
        case presented as SecondScreenViewController: return CircleTransitioningAnimator(with: firstButton, presenting: true)
        case presented as ThirdScreenViewController: return ScalingTransitioningAnimator(isPresenting: true)
        default: return nil
        }
        
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissed {
        case dismissed as SecondScreenViewController: return CircleTransitioningAnimator(with: firstButton, presenting: false)
        case dismissed as ThirdScreenViewController: return ScalingTransitioningAnimator(isPresenting: false)
        default: return nil
        }
    }
}

extension FirstScreenViewController {
    private struct Constants {
        static let seconsScreenSegueIdentifier = "showSecondScreen"
        static let thirdScreenSegueIdentifier = "showThirdScreen"
        static let firstButtonTitle = "🌎"
        static let firstButtonPoint = CGPoint(x: UIScreen.main.bounds.width / 1.5, y: UIScreen.main.bounds.height / 1.5)
        
        static let secondButtonTitle = "🌕"
        static let secondButtonPoint = CGPoint(x: UIScreen.main.bounds.width / 2.5, y: UIScreen.main.bounds.height / 2.5)
    }
}
