//
//  FavoriteMoviesViewModel.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 29/08/24.
//

import Foundation

protocol FavoriteMovieViewModelProtocol: AnyObject {
    func didUpdateMovie()
}

class FavoriteMoviesViewModel {
    
    private(set) var savedMovies: [Movie] = []
    
    weak var delegate: FavoriteMovieViewModelProtocol?
    
    func loadSavedMovies() {
        let userDefaults = UserDefaults.standard
        
        if let savedMoviesData = userDefaults.data(forKey: "favoriteCollection") {
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: savedMoviesData)
                savedMovies = movies
                delegate?.didUpdateMovie()
                print("Loaded Movies: \(savedMovies)")
            } catch {
                print("Failed to decode movies: \(error)")
            }
        } else {
            print("No saved movies found.")
        }
    }
}
