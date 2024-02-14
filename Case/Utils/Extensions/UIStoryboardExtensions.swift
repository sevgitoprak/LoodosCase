//
//  UIStoryboardExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 11.02.2024.
//

import Foundation
import UIKit

protocol StoryboardIdentifier {
    static var identifier: String { get }
}

extension UIStoryboard {
    
    enum Storyboards: String {
        case main
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: Storyboards, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    static func storyboard(_ storyboard: Storyboards, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(storyboard: storyboard, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        return viewController
    }
}
