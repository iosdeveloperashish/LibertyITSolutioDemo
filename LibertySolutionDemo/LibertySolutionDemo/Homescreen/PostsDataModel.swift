//
//  PostsDataModel.swift
//  LibertySolutionDemo
//
//  Created by Ashish Viltoriya on 03/04/21.
//

import Foundation

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 },
 
 */

struct Posts: Codable {
    let userId, id: Int
    let title, body: String
    var isFavourite = false
    
    enum CodingKeys: String, CodingKey {
        case userId
        case id
        case title
        case body
    }
    
}
