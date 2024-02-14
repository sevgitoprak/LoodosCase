//
//  UIFontExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation
import UIKit

protocol FontSizeProtocol {
    func size(_ size: CGFloat) -> UIFont?
}

extension FontSizeProtocol where Self: RawRepresentable, Self.RawValue == String {
    
    func size(_ size: CGFloat) -> UIFont? {
        return UIFont(name: rawValue, size: size)
    }
}

extension UIFont {
    
    enum montserrat: String, FontSizeProtocol {
        case regular = "Montserrat-Regular"
        case bold = "Montserrat-Bold"
        case light = "Montserrat-Light"
        case semibold = "Montserrat-SemiBold"
    }
}

