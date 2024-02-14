//
//  PageHelper.swift
//  Case
//
//  Created by Sevgi Toprak on 11.02.2024.
//

import Foundation
import UIKit

protocol Pageable {
    var pageHelper: PageHelper { get }
}

extension UIViewController: Pageable {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    var pageHelper: PageHelper {
        return PageHelper(viewController: self)
    }
}

struct PageHelper {
    
    let viewController: UIViewController
    
    func instantiateHomeViewController() -> SearchViewController {
        let earchViewController: SearchViewController = UIStoryboard.storyboard(.main).instantiateViewController()
        return earchViewController
    }
    
    func instantiateMovieListViewController() -> MovieListViewController {
        let movieListViewController: MovieListViewController = UIStoryboard.storyboard(.main).instantiateViewController()
        return movieListViewController
    }
    
    func pushToMovieDetailViewController(movie: Movie) {
        let movieDetailViewController: MovieDetailViewController = UIStoryboard.storyboard(.main).instantiateViewController()
        movieDetailViewController.movie = movie
        viewController.navigationController?.pushViewController(movieDetailViewController, animated: true)
    }

}
