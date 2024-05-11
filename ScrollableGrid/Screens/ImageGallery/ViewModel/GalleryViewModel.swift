//
//  GalleryViewModel.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import Foundation

final class GalleryViewModel {
    
    var images: [ImageModel] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding
    
    func fetchImages() {
        eventHandler?(.loading)
        
        APIManager.shared.request(
            moduleType: [ImageModel].self,
            type: EndPointItems.galleryImages) { response in
            self.eventHandler?(.stopLoading)
            
            switch response {
            case .success(let images):
                self.images = images
                self.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension GalleryViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
