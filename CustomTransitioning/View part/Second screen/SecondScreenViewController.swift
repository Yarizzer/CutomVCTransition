//
//  SecondScreenViewController.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 23/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class SecondScreenViewController: UIViewController {

    var backButton: BackButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton = BackButton()
        backButton.center = Constants.screenCenter
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        self.view.addSubview(backButton)
    }

    @objc private func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SecondScreenViewController {
    private struct Constants {
        static let screenCenter = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    }
}
