//
//  movieTableViewCell.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImgView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    func configureCell(movie: Movie, cache: ImageCache) {
        movieTitle.text = movie.title
        movieReleaseDate.text = movie.year
        if let url = URL(string: movie.poster) {
            cache.toGetImage(from: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.moviePosterImgView.image = image
                    case .failure(let failure):
                        self.moviePosterImgView.image = UIImage(named: "splash_image")
                    }
                }
            }
        }
    }
    
}


