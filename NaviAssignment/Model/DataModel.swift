//
//  DataModel.swift
//  NaviAssignment
//
//  Created by Vikas Vaish on 06/08/22.
//

import Foundation

typealias DataModel = [DataModelElement]

// MARK: - DataModelElement
struct DataModelElement: Codable {
    let state: String
    let title: String
    let user: User
    let createdAt : String
    let closedAt: String?
    
   
    enum CodingKeys: String, CodingKey {
        case state, user, title
        case createdAt = "created_at"
        case closedAt = "closed_at"
       
    }
}

// MARK: - User
struct User: Codable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        
    }
}
