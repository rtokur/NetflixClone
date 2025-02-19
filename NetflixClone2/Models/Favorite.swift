//
//  File.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 12.02.2025.
//

import Foundation

class Favorite: Codable {
    // MARK: - Properties
    var id: Int?
    var URL: String?
    var name: String?
    var movie: Bool? 
    
    init(id: Int, URL: String, name: String, movie: Bool) {
        self.id = id
        self.URL = URL
        self.name = name
        self.movie = movie
    }
}
