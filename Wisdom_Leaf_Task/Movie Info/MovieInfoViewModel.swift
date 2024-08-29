//
//  MovieInfoViewModel.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 29/08/24.
//

import Foundation

protocol MovieInfo: AnyObject {
    func didGetMovie()
}

class MovieInfoViewModel {
    
    let baseURL = "https://www.omdbapi.com/"
    let apiKey = "625a9ba2"
    
    let apiKeyConst = "?apikey="
    let searchConst = "&s="
    let imdbIDConst = "&i="
    
    private(set) var movieInfo: MovieByIDApiResponseModel?
    weak var delegate: MovieInfo?
    
    func getMoviewithID(for imdbID: String) {
        
        let serviceURL = baseURL + apiKeyConst + apiKey + imdbIDConst + imdbID
        
        guard let url = URL(string: serviceURL) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print(response)
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            do {
                // Parse JSON into MoviesApiResponseModel
                let movieResponse = try JSONDecoder().decode(MovieByIDApiResponseModel.self, from: data)
                print("Response Model: \(movieResponse)")
                self.movieInfo = movieResponse
                self.delegate?.didGetMovie()
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
