//
//  File.swift
//  
//
//  Created by Oleksii Perov on 7/18/23.
//

import Foundation
import UIKit

public struct FontsColletion {
    struct Controls {
        let medium: UIFont
    }
    
    let controls: Controls
}

public struct ColorsCollection {
    struct Controls {
        struct Foreground {
            let active: UIColor
            let inactive: UIColor
        }
        
        let foreground: Foreground
    }
    
    let appAccent: UIColor
    let controls: Controls
}

public struct ImagesCollection {
    struct Controls {
        struct Background {
            let active: UIImage
            let inactive: UIImage
            let secondary: UIImage
            let accent: UIImage
        }
        
        let background: Background
    }
    
    struct Indicators {
        struct Chevron {
            let active: UIImage
            let inactive: UIImage
        }
        
        let chevron: Chevron
    }
    
    let controls: Controls
    let indicators: Indicators
}

public protocol AppTheme {
    var fonts: FontsColletion { get }
    var colors: ColorsCollection { get }
    var images: ImagesCollection { get }
}

public extension AppTheme where Self == TATheme {
    static var `default`: Self { TATheme() }
}
