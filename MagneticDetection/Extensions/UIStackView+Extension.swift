//
//  UIStackView+Extension.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

extension UIStackView {
    convenience init(
        arrangedSubviews: [UIView],
        axis: NSLayoutConstraint.Axis = .horizontal
    ) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }

    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach {
            addArrangedSubview($0)
        }
    }

    func removeArrangedSubviews_preTok() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
        }
    }
}
