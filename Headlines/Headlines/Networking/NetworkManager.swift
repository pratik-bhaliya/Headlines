//
//  NetworkManager.swift
//  Headlines
//
//  Created by Pratik Bhaliya on 25/7/20.
//  Copyright © 2020 Pratik Bhaliya. All rights reserved.
//

import Foundation


//Conform to the Error prototype
enum NetworkError: String, Error {
    case genericError = "Something went wrong. Please try again later"
    case urlEndPointError = "Please check your url endpoint."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}

typealias NetworkResult = (Result<Data, NetworkError>) -> Void

/// Protocol oriented service type
protocol NetworkServiceProtocol: class {
    //typealias completionDataHandler<T> = (_ response: T?, _ error: NetworkError?) -> Void
    typealias completionDataHandler<T> = (Result<T, NetworkError>) -> Void
    func get<T: Codable>(with endRoute: NewsAPI, responseType: T.Type, completion: @escaping completionDataHandler<T>)
}

class NetworkManager: NetworkServiceProtocol {
    
    /// Single instance creation
    private init() {}
    static let shared = NetworkManager()
    
    func get<T: Codable>(with endRoute: NewsAPI, responseType: T.Type, completion: @escaping completionDataHandler<T>) {
        
        guard let endPoint = NewsServerConstant.serverBaseURL.appendingPathComponent(endRoute.path).absoluteString.removingPercentEncoding else {
            completion(.failure(.urlEndPointError))
            return
        }
        
        /// Initialise with string.
        /// Returns `nil` if a `URL` cannot be formed with the string (for example, if the string contains characters that are illegal in a URL, or is an empty string).
        guard let url = URL(string: endPoint) else {
            completion(.failure(.urlEndPointError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // check for error and return to completion handler
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            // data received from server
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            let response = ResponseData(data: data)
            let decodedResponse = response.decode(responseType)
            guard let decodedData = decodedResponse.decodedData else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(decodedData))
        }
        
        task.resume()
    }
}
