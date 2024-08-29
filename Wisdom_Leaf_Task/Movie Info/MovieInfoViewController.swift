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
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
}
