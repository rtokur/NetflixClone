//
//  Movie.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation
class Movie: Codable {
    // MARK: - Properties
    let id: Int?
    let title:String?
    let overview:String?
    let releaseDate:String?
    let posterPath:String?
    let genreIds: [Int]?
    let vote: Double?
    let backdropPath: String?
    
    // MARK: - Computed Properties
    var posterURL: URL? {
        guard let posterPath = posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return nil
        }
        return url
    }
    
    var posterBackURL: URL? {
        guard let posterPath = backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return nil
        }
        return url
    }
    // MARK: - Coding Keys
    private enum CodingKeys: String,CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case vote = "vote_average"

    }
}
