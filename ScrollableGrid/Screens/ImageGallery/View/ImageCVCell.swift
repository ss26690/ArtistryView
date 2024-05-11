//
//  imageCVCell.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import UIKit

class ImageCVCell: UICollectionViewCell {
    
    var image: ImageModel? {
        didSet { // Property Observer
            imageConfiguration()
        }
    }
    
    @IBOutlet weak var cellImageView: LazyImageView!
    
    private func imageConfiguration() {
        
        // frame prepare
        cellImageView.layer.cornerRadius = 10
        cellImageView.layer.borderColor = UIColor.gray.cgColor
        cellImageView.layer.borderWidth = 1
        cellImageView.image = UIImage(named: "placeholder")
        
        // start image downloading process
        guard let image else { return }
        
        guard let domain = image.thumbnail?.domain,
        let basePath = image.thumbnail?.basePath,
        let key = image.thumbnail?.key else { return }
        
        let imageURL: String = domain + "/" + basePath + "/0/" + key
        
        if let url = URL(string: imageURL) {
            cellImageView.loadImage(url: url) { [weak self] loadedImage in
                DispatchQueue.main.async {
                    guard let loadedImage else {
                        self?.cellImageView.image = UIImage(named: "downloadFailed")
                        return
                    }
                    self?.cellImageView.image = loadedImage
                }
            }
        }
    }
    
}
