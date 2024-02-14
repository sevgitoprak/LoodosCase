//
//  UICollectionViewExtensions.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func dequeueReusableCellForIndexPath<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView & StoryboardIdentifier>(ofKind elementKind: String, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
