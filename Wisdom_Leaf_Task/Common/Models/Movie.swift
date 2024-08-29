//
//  MoviesApiResponseModel.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 28/08/24.
//

import Foundation

struct SearchResponseModel: Codable {
    let Search: [Movie]
    
//    enum CodingKeys: String, CodingKey {
//        case search = "Search"
//    }
}

struct Movie: Codable {
    let poster: String
    let title: String
    let type: String
    let year: String
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case title = "Title"
        case type = "Type"
        case year = "Year"
        case imdbID
    }
}
