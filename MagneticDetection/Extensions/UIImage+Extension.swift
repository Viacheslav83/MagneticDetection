//
//  UIImage+Extension.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

extension UIImage {
    static func image(
        name: ImageNameType,
        renderingMode: RenderingMode = .alwaysOriginal
    ) -> UIImage? {
        .init(named: name.rawValue)?
        .withRenderingMode(renderingMode)
    }
}
