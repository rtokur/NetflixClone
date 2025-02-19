//
//  Episode.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 3.02.2025.
//

import Foundation

class Episode : Codable {
    let id: Int?
    let episodeNumber: Int?
    let name: String?
    let overview: String?
    let runtime: Int?
    let seasonNumber: Int?
    let stillPath: String?
    
    // MARK: - Computed Properties
    var stillURL: URL? {
        guard let stillPath = stillPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(stillPath)") else {
            return nil
        }
        return url
    }
    
    enum CodingKeys: String,CodingKey {
        case id
        case episodeNumber = "episode_number"
        case name
        case overview
        case runtime
        case seasonNumber = "season_number"
        case stillPath = "still_path"
    }
}
