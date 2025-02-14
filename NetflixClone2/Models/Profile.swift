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
    let documentId: String?
    
    init(isEnabled: Bool?, profileImageURL: String?, profileName: String?, documentId: String?) {
        self.isEnabled = isEnabled
        self.profileImageURL = profileImageURL
        self.profileName = profileName
        self.documentId = documentId
    }
}
