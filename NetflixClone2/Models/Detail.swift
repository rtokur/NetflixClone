//
//  Detail.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 1.02.2025.
//

import Foundation

class Detail : Codable {
    // MARK: - Properties
    let id : Int?
    var runtime: Int?
    var numberOfSeasons: Int?
    var numberOfEpisodes: Int?
    let genres : [Genre]?
    enum CodingKeys: String, CodingKey {
        case id
        case runtime
        case numberOfSeasons = "number_of_seasons"
        case numberOfEpisodes = "number_of_episodes"
        case genres
    }
    
}
