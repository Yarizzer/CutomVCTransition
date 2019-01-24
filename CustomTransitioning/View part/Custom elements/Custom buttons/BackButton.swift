//
//  BackButton.swift
//  CustomTransitioning
//
//  Created by Yarr!zzeR on 24/01/2019.
//  Copyright © 2019 Yaroslav Abaturov. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    private func setupView() {
        self.frame.size = Constants.frameSize
        self.backgroundColor = Constants.backgroundColor
        
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderColor = Constants.borderColor.cgColor
        self.layer.borderWidth = Constants.borderWidth
        
        self.setTitle(Constants.title, for: .normal)
    }
}

extension BackButton {
    private struct Constants {
        static let frameSize = CGSize(width: 150.0, height: 50.0)
        static let backgroundColor: UIColor = .red
        static let cornerRadius: CGFloat = 25.0
        static let borderColor: UIColor = .orange
        static let borderWidth : CGFloat = 3.0
        static let title = "Back to first VC"
    }
}
