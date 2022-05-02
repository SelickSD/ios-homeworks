//
//  Post.swift
//  Navigation
//
//  Created by Сергей Денисенко on 21.03.2022.
//

import Foundation

struct Post: Decodable {
    
    struct Article: Decodable {
        let author, image, description, likes, views: String
        
        enum CodingKeys: String, CodingKey {
            case author, image, description, likes, views
        }
    }
    
    let newsPost: [Article]

    struct MyArticle {
        let author, image, description: String
        var likes, views: Int
    }
}


