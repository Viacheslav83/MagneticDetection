//
//  MainBottomView.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

final class ScanNetworkView: UIView {
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .customDarkViolet
        view.set(cornerRadius: 8)
        return view
    }()
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [label1, label2, label3, button],
            axis: .vertical
        )
        v.alignment = .fill
        v.spacing = 12
        return v
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Current Wi-Fi"
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 28)
        label.textColor = .customViolet
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "WIFI_Name"
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 18)
        label.textColor = .customSubtitleGary
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Ready to Scan this network"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setTitle("Scan current network", for: .normal)
        button.backgroundColor = .customViolet
        button.isUserInteractionEnabled = true
        button.set(cornerRadius: 25)
        return button
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
        mainView.backgroundColor = .customBlack
        mainView.setShadow()
    }
    
    private func setup() {
        add([
            mainView
        ])
        
        mainView.add([
            vStack
        ])
        
        mainView.autoPinEdgesToSuperView()
        
        NSLayoutConstraint.activate([
            vStack.top.constraint(equalTo: mainView.top, constant: 12),
            vStack.bottom.constraint(equalTo: mainView.bottom, constant: -12),
            vStack.leading.constraint(equalTo: mainView.leading, constant: 16),
            vStack.trailing.constraint(equalTo: mainView.trailing, constant: -16),
            
            button.height.constraint(equalToConstant: 50)
        ])
    }
}
