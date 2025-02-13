//
//  Profile.swift
//  NetflixClone2
//
//  Created by Rumeysa Tokur on 13.02.2025.
//

import Foundation

class Profile: Codable {
    // MARK: - Properties
    let isEnabled: Bool?
    let profileImageURL: String?
    let profileName: String?
    
    init(isEnabled: Bool?, profileImageURL: String?, profileName: String?) {
        self.isEnabled = isEnabled
        self.profileImageURL = profileImageURL
        self.profileName = profileName
    }
}
