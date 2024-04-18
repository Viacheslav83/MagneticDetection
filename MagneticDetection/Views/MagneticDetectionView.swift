//
//  MagneticDetectionView.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

protocol MagneticDetectionViewDelegate: AnyObject {
    func didTapSearchButton()
    func didUpdateAnimation()
}

final class MagneticDetectionView: UIView {
    
    private enum ButtonType {
        case search
        case stop
        
        var title: String {
            switch self {
            case .search:
                return "Search"
            case .stop:
                return "Stop"
            }
        }
    }
    
    weak var delegate: MagneticDetectionViewDelegate?
    
    private let buttonHeight: CGFloat = 50
    private var buttonType: ButtonType = .search
    private var position: CGFloat = 0
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    private let topImageView1: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .mainTopBackground)
        return i
    }()
    
    private let topImageView2: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .uImage)
        return i
    }()
    
    private let bottomImageView1: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .speedometr)
        return i
    }()
    
    private let dotImageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .dotLightPurple)
        return i
    }()
    
    private let arrowImageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.image = .image(name: .doubleArrowImage)
        return i
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .customFont(size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Search checking"
        return label
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setTitle("Search", for: .normal)
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
        
        NSLayoutConstraint.activate([
            topImageView1.width.constraint(equalTo: scrollView.width),
            bottomImageView1.width.constraint(equalTo: scrollView.width)
        ])
    }
    
    private func setup() {
        add([
            scrollView
        ])
        
        scrollView.add([
            topImageView1,
            topImageView2,
            bottomImageView1,
            arrowImageView,
            dotImageView,
            label,
            button
        ])
        
        scrollView.autoPinEdgesToSuperView()
        
        NSLayoutConstraint.activate([
            topImageView1.top.constraint(equalTo: scrollView.top, constant: -20),
            topImageView1.leading.constraint(equalTo: scrollView.leading),
            topImageView1.trailing.constraint(equalTo: scrollView.trailing),
            topImageView1.height.constraint(equalToConstant: UIScreen.main.bounds.width * 0.9),
            
            topImageView2.centerY.constraint(equalTo: topImageView1.centerY),
            topImageView2.centerX.constraint(equalTo: topImageView1.centerX),
            topImageView2.width.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8),
            topImageView2.height.constraint(equalToConstant: UIScreen.main.bounds.width * 0.45),
            
            bottomImageView1.top.constraint(equalTo: topImageView1.bottom, constant: 40),
            bottomImageView1.leading.constraint(equalTo: scrollView.leading),
            bottomImageView1.trailing.constraint(equalTo: scrollView.trailing),
            bottomImageView1.height.constraint(equalToConstant: UIScreen.main.bounds.width * 0.48),
            
            arrowImageView.width.constraint(equalToConstant: UIScreen.main.bounds.width / 2),
            arrowImageView.height.constraint(equalToConstant: UIScreen.main.bounds.width / 15),
            arrowImageView.centerX.constraint(equalTo: bottomImageView1.centerX),
            arrowImageView.centerY.constraint(equalTo: bottomImageView1.bottom),
            
            dotImageView.width.constraint(equalToConstant: UIScreen.main.bounds.width / 15),
            dotImageView.height.constraint(equalTo: dotImageView.width),
            dotImageView.centerX.constraint(equalTo: arrowImageView.centerX),
            dotImageView.centerY.constraint(equalTo: arrowImageView.centerY),
            
            label.top.constraint(equalTo: bottomImageView1.bottom, constant: 40),
            label.leading.constraint(equalTo: scrollView.leading),
            label.trailing.constraint(equalTo: scrollView.trailing),
            label.height.constraint(equalToConstant: 20),
            
            button.top.constraint(lessThanOrEqualTo: label.bottom, constant: 80),
            button.leading.constraint(equalTo: scrollView.leading, constant: 16),
            button.trailing.constraint(equalTo: scrollView.trailing, constant: -16),
            button.height.constraint(equalToConstant: 50),
            button.bottom.constraint(equalTo: scrollView.bottom, constant: -46),
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func generateValue() -> Int {
        let numbers = Array(0...180)
        let num = numbers.randomElement() ?? 0
        return num
    }
    
    func updateButton() {
        buttonType = buttonType == .search ? .stop : .search
        button.setTitle(buttonType.title, for: .normal)
    }
    
    func animateView() {
        let val = generateValue()
        let angel = convertDegreeToRadiant(position - CGFloat(val))
        label.text = buttonType == .search ? "Search checking" : "µT \(val)"
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.arrowImageView.transform = CGAffineTransform(rotationAngle: -angel)
        } completion: { [weak self] _ in
            if self?.buttonType == .search {
                self?.arrowImageView.transform = .identity
                self?.position = 0
            } else {
                self?.delegate?.didUpdateAnimation()
            }
        }

    }
    
    private func convertRadiantToDegree(degree: CGFloat) -> CGFloat {
        return degree / 100 * .pi
    }
    
    func convertDegreeToRadiant(_ number: CGFloat) -> CGFloat {
        return number * .pi / 180
    }
    
    @objc
    private func buttonTapped(_ sender: UITapGestureRecognizer) {
        delegate?.didTapSearchButton()
    }
}
