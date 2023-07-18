//
//  File.swift
//  
//
//  Created by Oleksii Perov on 7/18/23.
//

import Foundation
import UIKit

public struct TATheme: AppTheme {
    public var fonts = FontsColletion(
        controls: .init(
            medium: UIFont.systemFont(ofSize: 17, weight: .medium)
        )
    )
    
    public var colors = ColorsCollection(
        appAccent: UIColor(
            named: "AppAccentColor",
            in: Bundle.module,
            compatibleWith: nil
        )!,
        controls: .init(
            foreground: .init(
                active: UIColor(
                    named: "ControlActiveForegroundColor",
                    in: Bundle.module,
                    compatibleWith: nil
                )!,
                inactive: UIColor(
                    named: "ControlInactiveForegroundColor",
                    in: Bundle.module,
                    compatibleWith: nil
                )!
            )
        )
    )
    
    public var images = ImagesCollection(
        controls: .init(
            background: .init(
                active: UIImage(
                    named: "ControlActiveBackground",
                    in: Bundle.module,
                    compatibleWith: nil
                )!.resizableImage(
                    withCapInsets: .init(
                        top: 10,
                        left: 10,
                        bottom: 10,
                        right: 10
                    ),
                    resizingMode: .stretch
                ),
                inactive: UIImage(
                    named: "ControlInactiveBackground",
                    in: Bundle.module,
                    compatibleWith: nil
                )!.resizableImage(
                    withCapInsets: .init(
                        top: 10,
                        left: 10,
                        bottom: 10,
                        right: 10
                    ),
                    resizingMode: .stretch
                ),
                secondary: UIImage(
                    named: "TextFieldBackground",
                    in: Bundle.module,
                    compatibleWith: nil
                )!.resizableImage(
                    withCapInsets: .init(
                        top: 10,
                        left: 10,
                        bottom: 10,
                        right: 10
                    ),
                    resizingMode: .stretch
                ),
                accent: UIImage(
                    named: "AccentBackground",
                    in: Bundle.module,
                    compatibleWith: nil
                )!.resizableImage(
                    withCapInsets: .init(
                        top: 10,
                        left: 10,
                        bottom: 10,
                        right: 10
                    ),
                    resizingMode: .stretch
                )
            )
        ),
        indicators: .init(
            chevron: .init(
                active: UIImage(
                    named: "Chevron",
                    in: Bundle.module,
                    compatibleWith: nil
                )!,
                inactive: UIImage(
                    named: "ChevronInactive",
                    in: Bundle.module,
                    compatibleWith: nil
                )!
            )
        )
    )
}
