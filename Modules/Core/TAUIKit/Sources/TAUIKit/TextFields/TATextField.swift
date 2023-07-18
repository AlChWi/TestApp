//
//  TATextField.swift
//
//
//  Created by Oleksii Perov on 7/18/23.
//

import Combine
import Foundation
import UIKit

open class TATextField: UIView {
    open var placeholderText: String {
        didSet {
            wrappedTextField.placeholder = placeholderText
        }
    }
    
    open var textPublisher = CurrentValueSubject<String, Never>("")
    
    private var isActive = false {
        didSet {
            updateState()
        }
    }
    
    private let theme: AppTheme
    
    private let wrappedTextField = UITextField()
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(
            image: theme.images.controls.background.secondary
        )
        return imageView
    }()
    
    public init(placeholderText: String, theme: AppTheme) {
        self.placeholderText = placeholderText
        self.theme = theme
        
        super.init(frame: .zero)
        
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(wrappedTextField)
        wrappedTextField.translatesAutoresizingMaskIntoConstraints = false
        wrappedTextField.delegate = self
        wrappedTextField.placeholder = placeholderText
        let action = UIAction { [unowned wrappedTextField, unowned textPublisher] _ in
            textPublisher.send(wrappedTextField.text ?? "")
        }
        wrappedTextField.addAction(action, for: .editingChanged)
        
        let backgroundImageConstraints = [
            backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        let textFieldConstraints = [
            wrappedTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            wrappedTextField.topAnchor.constraint(equalTo: self.topAnchor),
            wrappedTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            wrappedTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        let constraints = backgroundImageConstraints + textFieldConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func updateState() {
        UIView.transition(
            with: backgroundImageView,
            duration: 0.3,
            options: [.transitionCrossDissolve, .curveEaseInOut]
        ) { [unowned self] in
                backgroundImageView.image = isActive
                    ? theme.images.controls.background.active
                    : theme.images.controls.background.secondary
            }
    }
}

extension TATextField: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        isActive = true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        isActive = false
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wrappedTextField.resignFirstResponder()
        return true
    }
}
