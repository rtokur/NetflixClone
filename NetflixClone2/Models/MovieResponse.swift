//
//  MovieResponse.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation
class MovieResponse : Codable {
    // MARK: - Properties
    let dates : Dates?
    let page: Int?
    let results : [Movie]?
    let totalPages : Int?
    let totalResults : Int?

    // MARK: - Coding Keys
    private enum CodingKeys:String,CodingKey {
        case dates
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
        
    }
}

class Dates :Codable {
    let maximum: String?
    let minimum: String?
}
