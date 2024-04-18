//
//  VerticalImageAndLabelView.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

final class VerticalImageAndLabelView: UIView {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkViolet
        view.set(cornerRadius: 16)
        return view
    }()
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        return i
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .customFont(size: 16)
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        mainView.backgroundColor = .customDarkViolet
        mainView.setShadow()
    }
    
    private func setup() {
        add([
            mainView
        ])
        
        mainView.add([
            imageView,
            titleLabel
        ])
        
        mainView.autoPinEdgesToSuperView()
        
        NSLayoutConstraint.activate([
            imageView.bottom.constraint(equalTo: mainView.centerY, constant: -8),
            imageView.centerX.constraint(equalTo: centerX),
            
            titleLabel.top.constraint(equalTo: mainView.centerY, constant: 8),
            titleLabel.centerX.constraint(equalTo: centerX),
            
            imageView.height.constraint(equalToConstant: 44),
            imageView.width.constraint(equalToConstant: 44 * 0.7),
            
            titleLabel.height.constraint(equalToConstant: 40)
        ])
    }
    
    func configureUI(text: String, imageType: ImageNameType) {
        titleLabel.text = text
        imageView.image = .image(name: imageType)
    }
}
