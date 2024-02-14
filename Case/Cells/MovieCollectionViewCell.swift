//
//  MovieCollectionViewCell.swift
//  Case
//
//  Created by Sevgi Toprak on 13.02.2024.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI Properties
    
    @IBOutlet private weak var imgPoster: UIImageView!
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblYear: UILabel!
    
    // MARK: - Helpers
    
    func configureCell(_ object: Movie) -> Void {
        imgPoster.kf.setImage(with: object.posterURL, placeholder: UIImage(named: "defaultMoviePoster"))
        lblTitle.text = object.title
        lblYear.text = object.year
    }
}
