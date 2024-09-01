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
        
        // Set default or placeholder image first
        moviePosterImgView.image = UIImage(named: "default_image")
        
        // Check for valid URL
        guard let url = URL(string: movie.poster) else {
            moviePosterImgView.image = UIImage(named: "splash_image")
            return
        }
        
        // Fetch image from cache or download if not available
        if let cachedImage = cache.getImage(for: url) {
            // If the image is already cached, use it
            self.moviePosterImgView.image = cachedImage
        } else {
            // Download image if it's not in cache
            cache.downloadImage(from: url) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self?.moviePosterImgView.image = image
                    case .failure:
                        self?.moviePosterImgView.image = UIImage(named: "splash_image")
                    }
                }
            }
        }
    }
}



