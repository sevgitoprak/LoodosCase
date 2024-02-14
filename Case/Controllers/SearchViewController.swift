//
//  SearchViewController.swift
//  Case
//
//  Created by Sevgi Toprak on 11.02.2024.
//

import UIKit
import PKHUD

final class SearchViewController: UIViewController {
    
    // MARK: - UI Properties
    
    @IBOutlet private weak var lblSearch: UILabel!
    @IBOutlet private weak var txtSearch: UITextField!
    @IBOutlet private weak var viewSearch: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: - Properties
    
    private var movies: [Movie] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSearchView))
        viewSearch.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Helpers
    
    private func searchMovie(with searchString: String) {
        showLoadingIndicator()
        APIClient.searchMovies(searchString) { [weak self] result in
            self?.hideLoadingIndicator()
            guard let self = self else { return }
            switch result {
            case .success(let searchResult):
                self.movies = searchResult.movies
            case .failure(let error):
                self.movies.removeAll()
                print("Error: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                self.updateMoviesList()
            }
        }
        
        AnalyticsManager.shared.logMovieSearch(query: searchString, numberOfResults: movies.count)
    }
    
    private func updateMoviesList() {
        guard let homeViewController = parent as? HomeViewController else {
            return
        }
        
        homeViewController.updateMoviesList(movies: movies)
    }
    
    @objc private func tappedSearchView() {
        self.txtSearch.becomeFirstResponder()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            
            self.txtSearch.isHidden = false
            self.txtSearch.alpha = 1
            self.lblSearch.textColor = UIColor.blueColor
            self.lblSearch.font = UIFont.systemFont(ofSize: 10)
            self.viewSearch.layer.borderWidth = 1
            self.viewSearch.layer.borderColor = UIColor.blueColor?.cgColor
            stackView.layoutIfNeeded()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func tappedCancel(_ sender: UIButton) {
        txtSearch.text = ""
        searchMovie(with: "")
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.txtSearch.alpha = 0
            self.txtSearch.isHidden = true
            self.lblSearch.textColor = UIColor.descriptionColor
            self.viewSearch.layer.borderWidth = 0
        }
    }
    
}

// MARK: - UITextField Delegate

extension SearchViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let newText = currentText.replacingCharacters(in: range, with: string)
        searchMovie(with: newText)
        return true
    }
}
