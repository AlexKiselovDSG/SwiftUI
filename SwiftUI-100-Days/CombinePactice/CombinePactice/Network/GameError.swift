//
//  GameError.swift
//  CombinePactice
//
//  Created by Kiselov, Oleksandr on 1/18/22.
//

import Foundation

enum GameError: LocalizedError, Identifiable{
    var id: String { localizedDescription }
    case statusCode
    case decoding
    case invalidImage
    case invalidURL
    case other(Error)
    
    static func map(_ error: Error) -> GameError {
        return (error as? GameError) ?? .other(error)
    }
    
    var errorDescription: String {
        switch self {
        case .statusCode: return "Server responded with error.\nPossibly Rate Limit Exceeded"
        case .decoding: return "Error decoding data"
        case .invalidImage: return "Invalid image"
        case .invalidURL: return "Invalid URL"
        case .other(_): return self.localizedDescription
        }
    }
}
