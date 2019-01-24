//
//  TransitioningButton.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 23/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class FirstTransitioningButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.frame = CGRect(origin: .zero, size: CGSize(width: Constants.width, height: Constants.height))
        self.backgroundColor = Constants.backgroundColor
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.masksToBounds = true
        self.layer.borderColor = Constants.borderColor.cgColor
        self.layer.borderWidth = Constants.borderWidth
    }
}

extension FirstTransitioningButton {
    private struct Constants {
        static let width: CGFloat = 50.0
        static let height: CGFloat = 50.0
        static let backgroundColor: UIColor = .red
        static let cornerRadius: CGFloat = 25.0
        static let borderColor: UIColor = .orange
        static let borderWidth : CGFloat = 3.0
    }
}
