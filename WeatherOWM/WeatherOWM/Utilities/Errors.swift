//
//  Errors.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import Foundation

enum APIConfigError: Error, LocalizedError {
    case fileNotFound
    case decodingError(underlyingError: Error)
    case dataNotLoaded(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound: return "The file containing the API key was not found. Please add a file named 'APIConfig.json' in the root of the project with the API key inside."
        case .decodingError(underlyingError: let error): return "Failed to decode the data. \(error.localizedDescription)"
        case .dataNotLoaded(underlyingError: let error): return "Failed to load the data. \(error.localizedDescription)"
        }
    }
}

enum NetworkError: Error, LocalizedError {
    case missingConfig
    case invalidURL
    case invalidResponse
    case httpStatus(code: Int)
    case decoding(Error)
    
    var errorDescription: String? {
        switch self {
        case .missingConfig: 
            return "The API configuration is missing. Please check the APIConfig.json file."
        case .invalidURL:
            return "The URL provided is invalid."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .httpStatus(let code):
            return "HTTP error with status code: \(code)."
        case .decoding(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}
