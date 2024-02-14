//
//  MovieListViewController.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import UIKit
import IGListKit

final class MovieListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var stackEmptyList: UIStackView!
    
    // MARK: - Properties
    
    var movies: [Movie] = [] {
        didSet {
            preloadMovieDetails()
        }
    }
    
    private lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        return adapter
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preloadMovieDetails()
    }
    
    // MARK: - Helpers
    
    private func preloadMovieDetails() {
        for movie in movies {
            APIClient.getMovieDetails(movie.imdbID) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let movieDetails):
                    if let index = self.movies.firstIndex(where: { $0.imdbID == movie.imdbID }) {
                        self.movies[index].details = movieDetails
                        self.adapter.reloadObjects([self.movies[index]])
                    }
                case .failure(let error):
                    print("Failed to fetch movie details: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func performUpdates(movies: [Movie]?) {
        guard let movies = movies else {return}
        self.movies = movies
        adapter.performUpdates(animated: true)
    }
    
}

//MARK: - ListAdapterDataSource
extension MovieListViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return movies
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let movie = object as? Movie else {
            fatalError("Unexpected object type")
        }
        return MovieSectionController(movie: movie)
    }
    
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return stackEmptyList
    }
    
    
}

