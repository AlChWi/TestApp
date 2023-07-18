//
//  RegistrationCodeViewController.swift
//
//
//  Created by Oleksii Perov on 7/18/23.
//

import Combine
import Foundation
import TAUIKit
import UIKit

final class RegistrationCodeViewController: KeyboardReactiveViewController {
    private enum Constants {
        enum Strings {
            static let continueButtonTitle = NSLocalizedString(
                "registration_code_vc_continue",
                value: "Continue",
                comment: "Continue to next screen"
            )
            static let title = NSLocalizedString(
                "registration_code_vc_title",
                value: "Get started",
                comment: "Registration code screen title"
            )
            static let subtitle = NSLocalizedString(
                "registration_code_vc_subtitle",
                value: "Enter the registration code to begin.",
                comment: "Registration code screen subtitle"
            )
            static let textFieldPlaceholder = NSLocalizedString(
                "registration_code_vc_textField_placeholder",
                value: "Registration code",
                comment: "Registration code screen text field placeholder"
            )
        }
        enum Margins {
            static let horizontal: CGFloat = 16
        }
    }
    
    var router: OnboardingRouting?
    
    private let theme: AppTheme
    
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = Constants.Strings.title
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = .black
        return label
    }()
    private lazy var subtitleLabel = {
        let label = UILabel()
        label.text = Constants.Strings.subtitle
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    private lazy var textField = {
        let textField = TATextField(
            placeholderText: Constants.Strings.textFieldPlaceholder,
            theme: theme
        )
        return textField
    }()
    private lazy var continueButton = TAChevronButton(
        title: Constants.Strings.continueButtonTitle,
        onTap: showLoadingScreen,
        theme: theme
    )
    private var continueButtonBottomAnchor: NSLayoutConstraint?
    
    private lazy var codeValidator: AnyPublisher<Bool, Never> = {
        textField.textPublisher
            .map { text in
                let isProperLength = text.count == 5
                let containsOnlyDigits = CharacterSet(
                    charactersIn: text
                ).isSubset(of: CharacterSet.decimalDigits)
                return isProperLength && containsOnlyDigits
            }
            .eraseToAnyPublisher()
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(theme: AppTheme) {
        self.theme = theme

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        navigationController?.setNavigationBarHidden(true, animated: false)
        codeValidator
            .sink { [weak continueButton] isValidCode in
                continueButton?.isEnabled = isValidCode
            }
            .store(in: &cancellables)
    }
    
    override func keyboardWillShow(withSize size: CGRect, duration: CGFloat) {
        continueButtonBottomAnchor?.constant = -size.height - 16
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func keyboardWillHide(withDuration duration: CGFloat) {
        continueButtonBottomAnchor?.constant = -16
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupSubviews() {
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(continueButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        
        let continueButtonBottomAnchor = continueButton.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -Constants.Margins.horizontal
        )
        self.continueButtonBottomAnchor = continueButtonBottomAnchor
        let buttonConstraints = [
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margins.horizontal),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margins.horizontal),
            continueButtonBottomAnchor,
            continueButton.heightAnchor.constraint(equalToConstant: 54)
        ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 31)
        ]
        let subtitleLabelConstraints = [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            subtitleLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
        ]
        let textFieldConstraints = [
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Margins.horizontal),
            textField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 41),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Margins.horizontal),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ]
        let constraints = buttonConstraints
            + titleLabelConstraints
            + subtitleLabelConstraints
            + textFieldConstraints
        NSLayoutConstraint.activate(constraints)
    }
    
    private func showLoadingScreen() {
        router?.showLoadingScreen()
    }
}
