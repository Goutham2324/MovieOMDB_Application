//
//  MovieInfoViewController.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

class MovieInfoViewController: UIViewController {
    
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieGenreLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieDescriptionTextView: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movieInfoViewModel = MovieInfoViewModel()
    
    var movieInfo: String?
    
    var imageCache = ImageCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDescriptionTextView.isUserInteractionEnabled = false
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        configureView()
        movieInfoViewModel.delegate = self
    }
    
    func configureView() {
        if let movieInfo = movieInfo {
            movieInfoViewModel.getMoviewithID(for: movieInfo)
        }
    }
    
}

extension MovieInfoViewController: MovieInfo {
    func didGetMovie() {
        DispatchQueue.main.async {
            self.movieTitleLbl.text = self.movieInfoViewModel.movieInfo?.title
            self.movieGenreLbl.text = self.movieInfoViewModel.movieInfo?.genre
            self.movieRatingLbl.text = self.movieInfoViewModel.movieInfo?.imdbRating
            self.movieDescriptionTextView.text = self.movieInfoViewModel.movieInfo?.plot
            
            if let posterURLString = self.movieInfoViewModel.movieInfo?.poster, let url = URL(string: posterURLString) {
                if let cachedImage = self.imageCache.getImage(for: url) {
                    self.movieImageView.image = cachedImage
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                } else {
                    self.imageCache.downloadImage(from: url) { result in
                        DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            self.activityIndicator.isHidden = true
                            switch result {
                            case .success(let image):
                                self.movieImageView.image = image
                            case .failure(let failure):
                                self.movieImageView.image = UIImage(named: "splash_image")
                            }
                        }
                    }
                }
            }
            else {
                self.movieImageView.image = UIImage(named: "default_image")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            }
        }
    }
}
