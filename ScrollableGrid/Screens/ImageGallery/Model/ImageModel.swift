//
//  ImageModel.swift
//  ScrollableGrid
//
//  Created by Saurav Sagar on 11/05/24.
//

import Foundation

struct ImageModel : Decodable {
    let thumbnail: Thumbnail?
}

struct Thumbnail : Decodable {
    let domain: String?
    let basePath: String?
    let key: String?
}
