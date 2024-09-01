//
//  FavouriteMoviesViewController.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

class FavouriteMoviesViewController: UIViewController {
    
    @IBOutlet weak var favoriteMovieCollectionView: UICollectionView!
    
    private var favoriteViewModel: FavoriteMoviesViewModel = FavoriteMoviesViewModel()
    var savedMovies: [Movie] = []
    var imageCache = ImageCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        favoriteMovieCollectionView.dataSource = self
        favoriteMovieCollectionView.delegate = self
        favoriteViewModel.delegate = self
        loadSavedMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSavedMovies()
    }
    
    private func loadSavedMovies() {
        favoriteViewModel.loadSavedMovies()
    }
}

extension FavouriteMoviesViewController: FavoriteMovieViewModelProtocol {
    func didUpdateMovie() {
        DispatchQueue.main.async {
            self.savedMovies = self.favoriteViewModel.savedMovies
            self.favoriteMovieCollectionView.reloadData()
        }
    }
}
