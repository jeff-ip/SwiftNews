//
//  SwiftNewsItem.swift
//  SwiftNews
//
//  Created by Jeffrey Ip on 2020-09-11.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation

//Parses top level of reddit json response
struct Response: Codable {
    struct Children: Codable {
        struct SwiftNewsData: Codable {
            let data: SwiftNewsItem
        }
        let children: [SwiftNewsData]
    }
    let data: Children
}

struct SwiftNewsItem: Codable {
    let text: String
    let title: String
    let thumbnailString: String
    var thumbnailUrl: URL? {
        get {
            if thumbnailString.hasPrefix("http") {
                return URL(string: thumbnailString)
            }
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case text = "selftext"
        case thumbnailString = "thumbnail"
        case title
    }
}
