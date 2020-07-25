//
//  EndPointType.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation

// Declare HTTPMethod
enum HTTPMethod: String {
    case get = "GET"
}

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod  { get }
}
