//
//  Detail.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation

class Detail : Codable {
    // MARK: - Properties
    let backdropPath : String?
    let id : Int?
    var runtime: Int?
    var numberOfSeasons: Int?
    var numberOfEpisodes: Int?
    let genres : [Genre]?
    
    // MARK: - Computed Properties
    var posterURL: URL? {
        guard let posterPath = backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")") else {
            return nil
        }
        return url
    }
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case runtime
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case genres
    }
    
}
