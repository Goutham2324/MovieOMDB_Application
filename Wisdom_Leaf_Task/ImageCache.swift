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
    
    func toGetImage(from posterURL: URL, completion: @escaping (Result<UIImage, Error>) -> ()) {
        
    }
    
}
