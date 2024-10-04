//
//  FireBaseAnalytics.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 04/10/24.
//

import Foundation
import FirebaseAnalytics
import FirebaseFirestore

class FireBaseAnalyticsForMovies {
    
    func logMovieSearchEvent(movieName: String) {
        Analytics.logEvent("movie_search", parameters: [
            "movie_name": movieName
        ])
    }
    
    
    
    func storeNumberOfTimesMovieSearched(movieName: String) {
        let db = Firestore.firestore()
        let movieDocRef = db.collection("movieSearches").document(movieName)
        
        // Check if the movie already exists in Firestore
        movieDocRef.getDocument { (document, error) in
            if let document = document, document.exists {
                // Movie exists, increase the search count
                if let currentCount = document.data()?["searchCount"] as? Int {
                    movieDocRef.updateData(["searchCount": currentCount + 1]) {
                        err in
                        if let err = err {
                            print("Error updating count: \(err)")
                        } else {
                            print("Search count updated successfully")
                        }
                    }
                }
            } else {
                // Movie doesn't exist, insert it with search count set to 1
                movieDocRef.setData([
                    "searchCount": 1
                ]) { err in
                    if let err = err {
                        print("Error creating new document: \(err)")
                    } else {
                        print("New movie document created with initial search count")
                    }
                }
            }
        }
    }
    
}
