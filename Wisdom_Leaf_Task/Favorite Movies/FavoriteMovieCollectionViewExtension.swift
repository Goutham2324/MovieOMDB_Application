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
        item.movieImgView = nil
        item.movieTitleLbl.text = savedMovie.title
        item.movieYearLbl.text = savedMovie.year
        
        return item
    }

}

extension FavouriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 190, height: 220)
    }
}
