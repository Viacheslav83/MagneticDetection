//
//  MagneticDetectionVC.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

final class MagneticDetectionVC: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView: MagneticDetectionView = {
        let view = MagneticDetectionView()
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        title = "Magnetic Detection"
    }
}

//MARK: - OnboardingViewController
private extension MagneticDetectionVC {
    func setupView() {
        view.backgroundColor = .customBlack
        
        mainView.delegate = self
        view.add([mainView])
        mainView.autoPinEdgesToSuperView()
    }
}

//MARK: - MainViewDelegate
extension MagneticDetectionVC: MagneticDetectionViewDelegate {
    func didUpdateAnimation() {
        mainView.animateView()
    }
    
    func didTapSearchButton() {
        mainView.updateButton()
        mainView.animateView()
    }
}
