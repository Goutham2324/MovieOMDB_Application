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
    
    let moviesViewModel = MoviesViewModel()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        moviesViewModel.delegate = self
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieText = searchBar.text else { return }
        activityIndicator.style = .medium
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        moviesViewModel.getMoviesWithSearch(for: movieText)
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MoviesViewController: MoviesViewModelProtocol {
    func didMoviesUpdate() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}
