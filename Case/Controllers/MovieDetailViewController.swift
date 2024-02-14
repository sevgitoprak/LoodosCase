//
// MovieDetailViewController.swift
// Case
//
// Created by Sevgi Toprak on 10.02.2024.

import UIKit
import Kingfisher

final class MovieDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var imgMoviePoster: UIImageView!
    @IBOutlet private weak var stackGenres: UIStackView!
    @IBOutlet private weak var stackIMDB: UIStackView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblInfo: UILabel!
    @IBOutlet private weak var lblIMDBRate: UILabel!
    @IBOutlet private weak var lblWriters: UILabel!
    @IBOutlet private weak var lblDirector: UILabel!
    @IBOutlet private weak var lblStars: UILabel!
    @IBOutlet private weak var lblStory: UILabel!
    
    // MARK: - Properties
    
    var movie: Movie?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helpers
    
    private func setupUI() {
        guard let movie = movie else { return }
        
        if let movieDetails = movie.details {
            updateUI(with: movieDetails)
        } else {
            showLoadingIndicator()
            fetchMovieDetails(imdbID: movie.imdbID)
        }
    }
    
    private func fetchMovieDetails(imdbID: String) {
        APIClient.getMovieDetails(imdbID) { [weak self] result in
            guard let self = self else { return }
            self.hideLoadingIndicator()
            
            switch result {
            case .success(let movieDetails):
                self.updateUI(with: movieDetails)
            case .failure(let error):
                print("Failed to fetch movie details: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with movieDetails: MovieDetails) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.configureImageView(with: movieDetails.posterURL)
            self.lblName.text = movieDetails.title
            self.lblInfo.text = "\(movieDetails.year) • \(movieDetails.runtime.trimNumericPart.formattedTimeFromMinutes) • \(movieDetails.country)"
            self.stackIMDB.isHidden = movieDetails.imdbRating == "N/A"
            self.lblIMDBRate.text = movieDetails.imdbRating != "N/A" ? movieDetails.imdbRating : nil
            self.lblWriters.text = movieDetails.writer
            self.lblDirector.text = movieDetails.director
            self.lblStars.text = movieDetails.actors
            self.lblStory.text = movieDetails.plot
            self.configureGenreLabels(genres: movieDetails.genre.components(separatedBy: ","))
        }
    }
    
    private func configureImageView(with url: URL?) {
        imgMoviePoster.kf.setImage(with: url, placeholder: UIImage(named: "defaultMoviePoster"))
    }
    
    private func configureGenreLabels(genres: [String]) {
        stackGenres.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for genre in genres {
            let genreLabel = createGenreLabel(with: genre)
            stackGenres.addArrangedSubview(genreLabel)
        }
    }
    
    private func createGenreLabel(with genre: String) -> UILabel {
        let genreLabel = UILabel()
        genreLabel.text = genre.trimmingCharacters(in: .whitespacesAndNewlines)
        genreLabel.textColor = .white
        genreLabel.textAlignment = .center
        genreLabel.font = UIFont.montserrat.regular.size(12.0)
        genreLabel.textColor = UIColor.titleColor
        genreLabel.layer.cornerRadius = 15
        genreLabel.layer.masksToBounds = true
        genreLabel.backgroundColor = UIColor.grayColor
        genreLabel.borderWidth = 1
        genreLabel.borderColor = UIColor.blueColor
        
        let labelWidth = genreLabel.intrinsicContentSize.width + 30
        genreLabel.widthAnchor.constraint(equalToConstant: labelWidth).isActive = true
        
        return genreLabel
    }
}
