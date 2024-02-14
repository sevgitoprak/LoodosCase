//
//  UICollectionViewCellExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation
import UIKit

extension UICollectionViewCell: StoryboardIdentifier {
    
    static var identifier: String {
        return String(describing: self)
    }
}
