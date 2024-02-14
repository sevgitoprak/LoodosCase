//
//  ListCollectionContext.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import Foundation
import IGListKit

extension ListCollectionContext {
    func dequeueReusableCellFromStoryboard<T: UICollectionViewCell>(_ index: Int,_ listSectionController: ListSectionController) -> T {
        return self.dequeueReusableCellFromStoryboard(withIdentifier: T.identifier, for: listSectionController, at: index) as! T
    }
}
