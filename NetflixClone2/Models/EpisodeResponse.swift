//
//  EpisodeResponse.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 4.02.2025.
//

import Foundation

class EpisodeResponse : Codable {
    let _id : String?
    let airDate: String?
    let episodes: [Episode]?
    let name: String?
    let overview : String?
    let id: Int?
    let posterPath: String?
    let seasonNumber: Int?
    let vote: Double?
    
    // MARK: - Computed Properties
    var posterURL: URL? {
        guard let posterPath = posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else {
            return nil
        }
        return url
    }
    
    enum CodingKeys: String, CodingKey {
        case _id
        case airDate = "air_date"
        case episodes
        case name
        case overview
        case id
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case vote = "vote_average"
    }
}
