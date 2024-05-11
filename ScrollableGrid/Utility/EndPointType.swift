//
//  EndPointType.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

protocol EndPointType {
    var path: String { get }
    var baseURl: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
}

enum EndPointItems {
    case galleryImages // Module
}

extension EndPointItems: EndPointType {
    var path: String {
        switch self {
        case .galleryImages:
            return "/api/v2/content/misc/media-coverages?limit=100"
        }
    }
    
    var baseURl: String {
        return "https://acharyaprashant.org"
    }
    
    var url: URL? {
        return URL(string:"\(baseURl)\(path)")
    }
    
    var method: HTTPMethods {
        switch self{
        case .galleryImages:
            return .get
        }
    }
}
