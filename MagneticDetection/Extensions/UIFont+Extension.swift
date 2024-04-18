//
//  UIFont+Extension.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

extension UIFont {
    enum FontType: String {
        case medium = "Roboto-Medium"
    }

    static func customFont(
        type: FontType = .medium,
        size: CGFloat
    ) -> UIFont {
        UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size, weight: .regular)
    }
}
