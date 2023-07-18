//
//  LoadingIndicatorViewController.swift
//
//
//  Created by Oleksii Perov on 7/19/23.
//

import Foundation
import UIKit

open class LoadingIndicatorViewController: UIViewController {
    private let theme: AppTheme
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    
    private lazy var indicatorBackgroundImageView: UIImageView = {
        let imageView = UIImageView(
            image: theme.images.controls.background.accent
        )
        return imageView
    }()
    
    private lazy var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    public init(theme: AppTheme) {
        self.theme = theme
        
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        if #available(iOS 16, *) {
            Task.detached {
                try await Task.sleep(for: .seconds(2))
                await MainActor.run { [weak self] in
                    self?.dismiss(animated: false, completion:nil)
                }
            }
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.transition(
            with: blurEffectView,
            duration: 0.33,
            options: [.transitionCrossDissolve, .curveEaseInOut]
        ) { [weak self] in
            self?.blurEffectView.isHidden = false
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.transition(
            with: blurEffectView,
            duration: 0.3,
            options: [.transitionCrossDissolve, .curveEaseInOut]
        ) { [weak self] in
            self?.blurEffectView.isHidden = true
        }
    }
    
    private func setupSubviews() {
        view.addSubview(blurEffectView)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.isHidden = true
        
        view.addSubview(indicatorBackgroundImageView)
        indicatorBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        let blurEffectConstraints = [
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        let indicatorBackgroundConstraints = [
            indicatorBackgroundImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicatorBackgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorBackgroundImageView.widthAnchor.constraint(equalToConstant: 100),
            indicatorBackgroundImageView.heightAnchor.constraint(equalToConstant: 100)
        ]
        let indicatorConstraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: indicatorBackgroundImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: indicatorBackgroundImageView.centerYAnchor)
        ]
        let constraints = blurEffectConstraints
            + indicatorBackgroundConstraints
            + indicatorConstraints
        NSLayoutConstraint.activate(constraints)
    }
}
