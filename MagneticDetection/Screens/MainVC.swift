//
//  MainVC.swift
//  MagneticDetection
//
//  Created by Viacheslav Markov on 18.04.2024.
//

import UIKit

final class MainVC: UIViewController {
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mainView: MainView = {
        let view = MainView()
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

//MARK: - OnboardingViewController
private extension MainVC {
    func setupMainView() {
        view.backgroundColor = .customBlack
        mainView.delegate = self
        view.add([mainView])
        mainView.autoPinEdgesToSuperView()
    }
}

//MARK: - MainViewDelegate
extension MainVC: MainViewDelegate {
    func didTapButton() {
        let vc = MagneticDetectionVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
