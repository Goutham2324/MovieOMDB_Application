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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoriteViewModel.loadSavedMovies()
        favoriteMovieCollectionView.dataSource = self
        favoriteMovieCollectionView.delegate = self
        favoriteMovieCollectionView.reloadData()
    }

}
