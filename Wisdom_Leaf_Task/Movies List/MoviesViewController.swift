//
//  MoviesViewController.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 27/08/24.
//

import Foundation
import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var searchForMoviesLbl: UILabel!
    
    let moviesViewModel = MoviesViewModel()
    let fireBaseAnalytics = FireBaseAnalyticsForMovies()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesViewModel.delegate = self
        
        moviesTableView.isHidden = true
        searchForMoviesLbl.text = "Search for any movies using search bar"
        setupActivityIndicator()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.style = .medium
        activityIndicator.center = self.view.center
        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieText = searchBar.text else { return }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchForMoviesLbl.isHidden = true
        moviesViewModel.getMoviesWithSearch(for: movieText)
        fireBaseAnalytics.logMovieSearchEvent(movieName: movieText)
        fireBaseAnalytics.storeNumberOfTimesMovieSearched(movieName: movieText)
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MoviesViewController: MoviesViewModelProtocol {
    func didMoviesUpdate() {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                
                if self.moviesViewModel.moviesData.isEmpty {
                    self.moviesTableView.isHidden = true
                    self.searchForMoviesLbl.isHidden = false
                    self.searchForMoviesLbl.text = "Search results are not found."
                } else {
                    self.moviesTableView.isHidden = false
                    self.searchForMoviesLbl.isHidden = true
                    self.moviesTableView.reloadData()
                }
            }
        }
}
