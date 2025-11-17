//
//  SplashViewController.swift
//  Reminder
//
//  Created by Gabriel on 22/08/25.
//

import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView
    weak var flowDelegate: SplashFlowDelegate?
    
    init(view: SplashView, flowDelegate: SplashFlowDelegate) {
        self.contentView = view
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        startBreathingAnimation()
        setupConstraints()
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupConstraints() {
        self.setupContentViewToBounds(contentView)
    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultsManager.loadUser(), user.rememberMe {
            flowDelegate?.navigateToHome()
        } else {
            animateLogoUp()
            self.flowDelegate?.showLoginBottomSheet()
        }
    }
}

extension SplashViewController {
    private func startBreathingAnimation() {
        UIView.animate(withDuration: 1.5, 
                      delay: 0,
                      options: [.curveEaseInOut],
                      animations: {
            self.contentView.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            self.decideNavigationFlow()
        }
    }
    
    private func animateLogoUp() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.contentView.imageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1).translatedBy(x: 0, y: -100)
        })
    }
}
