//
//  Serie.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation
class Serie: Codable {
    // MARK: - Properties
    let id: Int?
    let name: String?
    let overview: String?
    let genreIds: [Int]?
    let posterPath: String?
    let vote: Double?
    let firstAirDate: String?
    
    // MARK: - Computed Properties
    var posterURL: URL? {
        guard let posterPath = posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return nil
        }
        return url
    }
    
    private enum CodingKeys: String,CodingKey {
        case id
        case name
        case overview
        case genreIds = "genre_ids"
        case posterPath = "poster_path"
        case vote = "vote_average"
        case firstAirDate = "first_air_date"
    }
}
