//
//  MoviesViewModel.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 28/08/24.
//

import Foundation

protocol MoviesViewModelProtocol: AnyObject {
    func didMoviesUpdate()
}

class MoviesViewModel {
    
    // https://www.omdbapi.com/?apikey=625a9ba2&s=%22Avengers%22
    
    private(set) var moviesData: [Movie] = []
    let imageCache: ImageCache = ImageCache()
    weak var delegate: MoviesViewModelProtocol?
    
    let baseURL = "https://www.omdbapi.com/"
    let apiKey = "625a9ba2"
    
    let apiKeyConst = "?apikey="
    let searchConst = "&s="
    let imdbIDConst = "&i="
    
    func getMoviesWithSearch(for searchText: String) {
        
        let serviceURL = baseURL + apiKeyConst + apiKey + searchConst + searchText
        
        guard let url = URL(string: serviceURL) else {
            print("Invalid URL.")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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
                let moviesResponse = try JSONDecoder().decode(SearchResponseModel.self, from: data)
                print("Response Model: \(moviesResponse)")
                self.moviesData = moviesResponse.Search
                self.delegate?.didMoviesUpdate()
                
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func getPoster(for poster: String) {
        
    }
}
