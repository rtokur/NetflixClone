//
//  SerieResponse.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation
class SerieResponse: Codable {
    // MARK: - Properties
    let page: Int?
    let results: [Serie]?
    let totalPages: Int?
    let totalResults: Int?
    
    private enum CodingKeys: String,CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
