//
//  Headlines.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - TopHeadlines
class TopHeadlines: Object, Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

// MARK: - Article
class Article: Object, Codable {
    //let source: HeadlineSource? = nil
    @objc dynamic var author: String? = nil
    @objc dynamic var title: String? = nil
    @objc dynamic var articleDescription: String? = nil
    @objc dynamic var url: String? = nil
    @objc dynamic var urlToImage: String? = nil
    @objc dynamic var content: String? = nil

    enum CodingKeys: String, CodingKey {
        case author, title
        case articleDescription = "description"
        case url, urlToImage, content
    }
}

// MARK: - Source
class HeadlineSource: Object, Codable {
    let id: String = ""
    let name: String = ""
}