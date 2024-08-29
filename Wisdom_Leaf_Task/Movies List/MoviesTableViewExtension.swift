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
        cell.favoriteBtn.tag = indexPath.row
        cell.favoriteBtn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        cell.configureCell(movie: movieData, cache: moviesViewModel.imageCache)
        
        if !movieData.poster.isEmpty, let imageUrl = URL(string: movieData.poster) {
                   let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                       // Ensure the downloaded image data belongs to the current cell
                       if let data = data, let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                               if tableView.cellForRow(at: indexPath) == cell {
                                   cell.moviePosterImgView.image = image
                               }
                           }
                       } else {
                           DispatchQueue.main.async {
                               cell.moviePosterImgView.image = UIImage(named: "splash_image")
                           }
                       }
                   }
                   task.resume()
               } else {
                   cell.moviePosterImgView.image = UIImage(named: "defaultimg")
               }
               
               cell.selectionStyle = .none

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) 
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        tableView.deselectRow(at: indexPath, animated: false)
        vc.movieInfo = moviesViewModel.moviesData[indexPath.row].imdbID
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        let movies = moviesViewModel.moviesData // Assuming moviesData is an array of Movie objects
        
        do {
            // Encode the movies array into Data
            let encodedMovies = try JSONEncoder().encode(movies)
            // Save the encoded data to UserDefaults
            userDefaults.set(encodedMovies, forKey: "favoriteCollection")
            print("Movies saved successfully.")
        } catch {
            print("Failed to encode movies: \(error)")
        }
    }

    
}
