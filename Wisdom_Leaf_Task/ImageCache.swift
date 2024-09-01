//
//  ImageCache.swift
//  Wisdom_Leaf_Task
//
//  Created by Swejan Kothamasu on 28/08/24.
//

import Foundation
import UIKit

class ImageCache {
    
    private var cache: NSCache<NSString, UIImage> = .init()
    
    // Save image to cache
    func saveImage(_ image: UIImage, for url: URL) {
        let key = url.absoluteString as NSString
        cache.setObject(image, forKey: key)
    }
    
    // Fetch image from cache
    func getImage(for url: URL) -> UIImage? {
        let key = url.absoluteString as NSString
        return cache.object(forKey: key)
    }
    
    // Download image if not in cache
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                // Save to cache
                self?.saveImage(image, for: url)
                completion(.success(image))
            } else {
                let error = NSError(domain: "ImageDownloadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to download image."])
                completion(.failure(error))
            }
        }.resume()
    }
}

