//
//  CloseButton.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/4.
//

import Foundation
import UIKit

class CloseButton: UIButton {

    var closeView: (() -> Void)?

    func setup(image: ImageAsset) {
        addTarget(self, action: #selector(tapped(_:)), for: .touchUpInside)
        layoutPosition()
        setupBackgroundImage(image)
    }

    @objc func tapped(_ sender: UIButton) {
        closeView?()
    }

    private func setupBackgroundImage(_ asset: ImageAsset) {
        setBackgroundImage(UIImage.asset(asset), for: .normal)
    }

    private func layoutPosition() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.04),
            heightAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.04),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: 32),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -32)
        ])
    }
}
