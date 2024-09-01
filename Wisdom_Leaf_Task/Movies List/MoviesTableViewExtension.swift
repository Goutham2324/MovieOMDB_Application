//
//  extensionMoviesViewController.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesViewModel.moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        let movieData = moviesViewModel.moviesData[indexPath.row]
        
        // Configure the cell with movie data and image cache
        cell.configureCell(movie: movieData, cache: moviesViewModel.imageCache)
        
        // Configure the favorite button
        cell.favoriteBtn.tag = indexPath.row
        cell.favoriteBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieData = moviesViewModel.moviesData[indexPath.row]
        let imdbID = movieData.imdbID

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else {
            print("Error: Could not instantiate MovieInfoViewController from storyboard.")
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        vc.movieInfo = imdbID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        
        // Ensure the index is within bounds
        guard rowIndex >= 0 && rowIndex < moviesViewModel.moviesData.count else {
            print("Invalid row index.")
            return
        }
        
        let movie = moviesViewModel.moviesData[rowIndex]
        var savedMovies: [Movie] = []
        
        let userDefaults = UserDefaults.standard
        
        if let savedMoviesData = userDefaults.data(forKey: "favoriteCollection") {
            do {
                savedMovies = try JSONDecoder().decode([Movie].self, from: savedMoviesData)
            } catch {
                print("Failed to decode saved movies: \(error)")
            }
        }
        
        if !savedMovies.contains(where: { $0.imdbID == movie.imdbID }) {
            savedMovies.append(movie)
            
            do {
                // Encode the updated movies array into Data
                let encodedMovies = try JSONEncoder().encode(savedMovies)
                // Save the updated array to UserDefaults
                userDefaults.set(encodedMovies, forKey: "favoriteCollection")
                print("Movie saved successfully: \(movie)")
            } catch {
                print("Failed to encode movies: \(error)")
            }
        } else {
            print("Movie is already in the favorites.")
        }
    }

    
}
