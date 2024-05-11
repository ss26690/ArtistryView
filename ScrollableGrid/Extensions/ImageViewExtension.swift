//
//  ImageViewExtension.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import UIKit

class LazyImageView: UIImageView {
    
    // MARK: - Properties
    var workItemReference: DispatchWorkItem? = nil
    private let cache = NSCache<NSString, UIImage>()
    typealias ImageHandler = (UIImage?) -> Void
        
    // Method to load an image from the given URL
    func loadImage(url: URL, completion: @escaping ImageHandler) {
        
        // Check if the image is already in the cache
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Cancel any ongoing image loading task
        workItemReference?.cancel()
        
        // Create a new DispatchWorkItem for image loading
        let imageLoadWorkItem = DispatchWorkItem { [weak self] in
            self?.downloadImageFromNetwork(url: url) { [weak self] image in
                if let image = image {
                    self?.cache.setObject(image, forKey: url.absoluteString as NSString)
                }
                completion(image)
            }
        }
        
        workItemReference = imageLoadWorkItem
        
        DispatchQueue.global(qos: .background).async(execute: imageLoadWorkItem)
    }
        
    // Method to download image data from network
    private func downloadImageFromNetwork(url: URL, completion: @escaping ImageHandler) {
        let imageData = try? Data(contentsOf: url)
        
        guard let imageData = imageData else {
            completion(nil)
            return
        }
        
        guard let requiredImage = UIImage(data: imageData) else {
            completion(nil)
            return
        }
        completion(requiredImage)
    }
}



