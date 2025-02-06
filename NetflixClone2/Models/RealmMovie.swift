//
//  RealmMovie.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 5.02.2025.
//

import Foundation
import RealmSwift
class RealmMovie: Object {
    // MARK: - Properties
    @objc dynamic var movieName: String = ""
    @objc dynamic var moviePath: String = ""
    
}

