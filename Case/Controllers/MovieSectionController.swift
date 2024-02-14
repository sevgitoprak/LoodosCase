//
//  MovieSectionController.swift
//  Case
//
//  Created by Sevgi Toprak on 11.02.2024.
//

import UIKit
import IGListKit

final class MovieSectionController: ListSectionController {
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
        inset = UIEdgeInsets(top: 2.5, left: 16, bottom: 16, right: 2.5)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        
        let cellWidth = (width / 3) - inset.left - inset.right
        let cellHeight = 250 - inset.top - inset.bottom
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else {return UICollectionViewCell()}
        let cell : MovieCollectionViewCell = context.dequeueReusableCellFromStoryboard(index, self)
        cell.configureCell(movie)
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        AnalyticsManager.shared.logMovieSelected(movieId: movie.imdbID, movieTitle: movie.title)
        (viewController as? MovieListViewController)?.pageHelper.pushToMovieDetailViewController(movie: movie)
    }
    
    override func didUpdate(to object: Any) {
        guard let object = object as? Movie else { return }
        movie = object
    }
}
