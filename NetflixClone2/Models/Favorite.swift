//
//  File.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 12.02.2025.
//

import Foundation

class Favorite: Codable {
    // MARK: - Properties
    var id: Int? = nil
    var URL: String? = nil
    var name: String? = nil
    
    init(id: Int, URL: String, name: String) {
        self.id = id
        self.URL = URL
        self.name = name
    }
}
