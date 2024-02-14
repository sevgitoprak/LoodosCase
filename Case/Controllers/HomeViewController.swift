//
//  HomeViewController.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    private weak var searchViewController: SearchViewController?
    private weak var movieListViewController: MovieListViewController?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchViewController()
    }
    
    // MARK: - Helpers
    
    private func setupSearchViewController() {
        let searchViewController = pageHelper.instantiateHomeViewController()
        self.searchViewController = searchViewController
        add(searchViewController, withFrame: CGRect(x: 20, y: 150, width: view.frame.width - 40 , height: 50))
        shouldHideKeyboardOnTap = true
    }
    
    func updateMoviesList(movies: [Movie]) {
        if let movieListViewController = movieListViewController {
            movieListViewController.performUpdates(movies: movies)
        } else {
            addMovieListViewController(movies: movies)
        }
    }
    
    private func addMovieListViewController(movies: [Movie]) {
        let movieListViewController = pageHelper.instantiateMovieListViewController()
        add(movieListViewController, withFrame: CGRect(x: 0, y: 220, width: view.frame.width, height: view.frame.height - 150))
        self.movieListViewController = movieListViewController
        movieListViewController.performUpdates(movies: movies)
    }
}
