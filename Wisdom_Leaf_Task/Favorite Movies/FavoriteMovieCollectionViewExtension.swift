//
//  FavoriteMovieCollectionViewExtension.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 29/08/24.
//

import Foundation
import UIKit

extension FavouriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionItem", for: indexPath) as! MovieCollectionItem
        let savedMovie = savedMovies[indexPath.item]
        item.movieTitleLbl.text = savedMovie.title
        item.movieYearLbl.text = savedMovie.year
        
        // Set a default image first
        item.movieImgView.image = UIImage(named: "default_image")
        
        // Load image using cache
        if let url = URL(string: savedMovie.poster) {
            if let cachedImage = imageCache.getImage(for: url) {
                item.movieImgView.image = cachedImage
            } else {
                imageCache.downloadImage(from: url) { [weak item] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let image):
                            item?.movieImgView.image = image
                        case .failure:
                            item?.movieImgView.image = UIImage(named: "splash_image")
                        }
                    }
                }
            }
        } else {
            item.movieImgView.image = UIImage(named: "splash_image")
        }
        
        return item
    }
}

extension FavouriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 220)
    }
}
