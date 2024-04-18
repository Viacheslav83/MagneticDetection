//
//  MainView.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func didTapButton()
}

final class MainView: UIView {
    weak var delegate: MainViewDelegate?
    private let buttonHeight: CGFloat = 50
    private let spacing: CGFloat = 20
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .topMagneticImage)
        return i
    }()
    
    private let scanView: ScanNetworkView = {
        let i = ScanNetworkView()
        i.backgroundColor = .clear
        return i
    }()
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [h1Stack, h2Stack],
            axis: .vertical
        )
        v.alignment = .fill
        v.backgroundColor = .clear
        v.spacing = 12
        return v
    }()
    
    private lazy var h1Stack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [topLeftView, topRightView],
            axis: .horizontal
        )
        v.alignment = .fill
        v.distribution = .fillEqually
        v.spacing = spacing
        return v
    }()
    
    private lazy var topRightView: VerticalImageAndLabelView = {
        let view = VerticalImageAndLabelView()
        
        view.set(cornerRadius: 8)
        return view
    }()
    
    private lazy var topLeftView: VerticalImageAndLabelView = {
        let view = VerticalImageAndLabelView()
        view.set(cornerRadius: 8)
        return view
    }()
    
    private lazy var h2Stack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [bottomLeftView, bottomRightView],
            axis: .horizontal
        )
        v.alignment = .fill
        v.distribution = .fillEqually
        v.spacing = spacing
        return v
    }()
    
    private lazy var bottomRightView: VerticalImageAndLabelView = {
        let view = VerticalImageAndLabelView()
        view.set(cornerRadius: 8)
        return view
    }()
    
    private lazy var bottomLeftView: VerticalImageAndLabelView = {
        let view = VerticalImageAndLabelView()
        view.set(cornerRadius: 8)
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        [topLeftView, topRightView, bottomLeftView, bottomRightView].forEach { v in
            let side = (UIScreen.main.bounds.width / 2) - 20
            NSLayoutConstraint.activate([
                v.height.constraint(equalToConstant: side),
                v.width.constraint(equalTo: v.height)
            ])
        }
        
        NSLayoutConstraint.activate([
            imageView.width.constraint(equalTo: scrollView.width)
        ])
    }
    
    private func setup() {
        add([
            scrollView
        ])
        
        scrollView.add([
            imageView,
            scanView,
            vStack
        ])
        
        scrollView.autoPinEdgesToSuperView()
        
        NSLayoutConstraint.activate([
            imageView.top.constraint(equalTo: scrollView.top),
            imageView.leading.constraint(equalTo: scrollView.leading),
            imageView.trailing.constraint(equalTo: scrollView.trailing),
            imageView.height.constraint(equalToConstant: UIScreen.main.bounds.width * 0.85),
            
            scanView.top.constraint(equalTo: imageView.bottomAnchor, constant: -12),
            scanView.leading.constraint(equalTo: scrollView.leading, constant: 16),
            scanView.trailing.constraint(equalTo: scrollView.trailing, constant: -16),
            
            vStack.top.constraint(equalTo: scanView.bottomAnchor, constant: 12),
            vStack.leading.constraint(equalTo: scrollView.leading, constant: 16),
            vStack.trailing.constraint(equalTo: scrollView.trailing, constant: -16),
            vStack.bottom.constraint(equalTo: scrollView.bottom, constant: -46),
        ])
        
        scanView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        bottomLeftView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }
    
    private func configureUI() {
        topLeftView.configureUI(text: "Infrared\n Detection", imageType: .cIcon)
        topRightView.configureUI(text: "Bluetooth\n Detection", imageType: .bIcon)
        bottomLeftView.configureUI(text: "Magnetic\n Detection", imageType: .uIcon)
        bottomRightView.configureUI(text: "Antispy\n Tips", imageType: .lIcon)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
//        delegate?.didTapSearchButton()
    }
    
    @objc
    private func viewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTapButton()
    }
}
