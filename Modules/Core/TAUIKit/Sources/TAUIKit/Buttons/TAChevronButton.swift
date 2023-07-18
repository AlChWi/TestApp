//
//  TAButton.swift
//
//
//  Created by Oleksii Perov on 7/18/23.
//

import Foundation
import UIKit

open class TAChevronButton: UIView {
    public typealias OnTapAction = () -> Void
    
    open var title: String?
    open var isEnabled: Bool {
        get {
            wrappedButton.isEnabled
        }
        set {
            let oldValue = wrappedButton.isEnabled
            wrappedButton.isEnabled = newValue
            if oldValue != newValue {
                updateState()
            }
        }
    }
    
    open var onTapAction: OnTapAction

    private let wrappedButton = UIButton()
    private lazy var chevronIndicator = {
        let imageView = UIImageView(
            image: isEnabled
                ? theme.images.indicators.chevron.active
                : theme.images.indicators.chevron.inactive
        )
        imageView.contentMode = .center
        return imageView
    }()
    private var theme: AppTheme
    
    private lazy var enabledStateConfiguration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.plain()
        configuration.background.image = theme.images.controls.background.active
        configuration.title = title
        let inset = -(chevronIndicator.image?.size.width ?? 0)
        configuration.contentInsets = .init(
            top: 0,
            leading: inset,
            bottom: 0,
            trailing: 0
        )
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [unowned self] attributes in
            var outgoing = attributes
            outgoing.font = theme.fonts.controls.medium
            outgoing.uiKit.foregroundColor = theme.colors.controls.foreground.active
            return outgoing
        }

        return configuration
    }()
    
    private lazy var disabledStateConfiguration: UIButton.Configuration = {
        let image = theme.images.controls.background.inactive
        var configuration = UIButton.Configuration.plain()
        configuration.background.image = image
        configuration.title = title
        let inset = -(chevronIndicator.image?.size.width ?? 0)
        configuration.contentInsets = .init(
            top: 0,
            leading: inset,
            bottom: 0,
            trailing: 0
        )
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { [unowned self] attributes in
            var outgoing = attributes
            outgoing.font = theme.fonts.controls.medium
            outgoing.uiKit.foregroundColor = theme.colors.controls.foreground.inactive
            return outgoing
        }
        
        return configuration
    }()
    
    public init(
        title: String?,
        onTap: @escaping OnTapAction = {},
        theme: AppTheme
    ) {
        self.title = title
        self.theme = theme
        self.onTapAction = onTap
        super.init(frame: .zero)
        setupSubviews()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) is not implemented")
    }
    
    private func setupSubviews() {
        addSubview(wrappedButton)
        wrappedButton.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction { [weak self] _ in
            self?.onTapAction()
        }
        wrappedButton.addAction(action, for: .touchUpInside)
        addSubview(chevronIndicator)
        chevronIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonConstraints = [
            wrappedButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            wrappedButton.topAnchor.constraint(equalTo: self.topAnchor),
            wrappedButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            wrappedButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        let chevronConstraints = [
            chevronIndicator.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            chevronIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            chevronIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            chevronIndicator.widthAnchor.constraint(equalToConstant: 13),
        ]
        let constraints = buttonConstraints + chevronConstraints
        NSLayoutConstraint.activate(constraints)
        wrappedButton.configuration = isEnabled
            ? enabledStateConfiguration
            : disabledStateConfiguration
        wrappedButton.configurationUpdateHandler = { [unowned self] button in
            let configuration = isEnabled
                ? enabledStateConfiguration
                : disabledStateConfiguration
            button.configuration = configuration
        }
        wrappedButton.setNeedsUpdateConfiguration()
    }
    
    private func updateState() {
        wrappedButton.setNeedsUpdateConfiguration()
        chevronIndicator.image = isEnabled
            ? theme.images.indicators.chevron.active
            : theme.images.indicators.chevron.inactive
    }
}
