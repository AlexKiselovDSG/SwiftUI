//
//  UnsplashAPI.swift
//  CombinePactice
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import Combine
import Foundation

enum UnsplashAPI {
    static let accessToken = "mAwIT_ZMS1CAjjhpKTaDZF8zJ1drH_gZmSNw5SF1rfk"
    
    
    static func randomImage() -> AnyPublisher<RandomImageResponse, GameError> {
        
        let url = URL(string: "https://api.unsplash.com/photos/random/?client_id=\(accessToken)")!
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Accept-Version", forHTTPHeaderField: "v1")
        
        return session.dataTaskPublisher(for: urlRequest)
            .tryMap { response -> Data in
                guard
                    let httpURLResponse = response.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                else {
                    throw GameError.statusCode
                }
                return response.data
            }
            .decode(type: RandomImageResponse.self, decoder: JSONDecoder())
            .mapError { GameError.map($0) }
            .eraseToAnyPublisher()
    }
}


