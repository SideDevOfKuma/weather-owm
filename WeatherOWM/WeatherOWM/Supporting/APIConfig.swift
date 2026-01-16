//
//  APIConfig.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//
import Foundation

struct APIConfig: Codable {
    let owmKey: String
    
    static let shared: APIConfig? = {
        do {
            return try loadAPIConfig()
        } catch {
            DLog("Failed to load API config with error: \(error)")
            return nil
        }
    }()
    
    /**
        NOTE:  This is not a good practice, the key needs to be retieved securely from the backend but it exceed the scope of this excersice.`
     */
    private static func loadAPIConfig() throws -> APIConfig {
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json") else {
            throw APIConfigError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
        } catch let error as DecodingError {
            throw APIConfigError.decodingError(underlyingError: error)
        } catch {
            throw APIConfigError.dataNotLoaded(underlyingError: error)
        }
    }
}
