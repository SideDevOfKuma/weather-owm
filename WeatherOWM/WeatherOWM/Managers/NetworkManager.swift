//
//  NetworkManager.swift
//  WeatherOWM
//
//  Created by Lucas Paintner on 07/01/2026.
//

import Foundation

enum WeatherFetchingStatus: Equatable {
    case notStarted
    case fetching
    case success
    case failed
}

struct NetworkManager {
    
    func createWeatherByGeoCodeRequest(lat: Double, lon: Double) throws -> URLRequest {
        guard let apiKey = APIConfig.shared?.owmKey else {
            throw NetworkError.missingConfig
        }
        
        var components = URLComponents(string: APIConstants.openWeatherMapBaseURL)
        components?.queryItems = [
            URLQueryItem(name: APIConstants.latitudeKey, value: lat.toString()),
            URLQueryItem(name: APIConstants.longitudeKey, value: lon.toString()),
            URLQueryItem(name: APIConstants.apiKey, value: apiKey),
            URLQueryItem(name: APIConstants.unitsKey, value: "metric")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
    func createWeatherByCityRequest(city: String) throws -> URLRequest {
        guard let apiKey = APIConfig.shared?.owmKey else {
            throw NetworkError.missingConfig
        }
        
        var components = URLComponents(string: APIConstants.openWeatherMapBaseURL)
        components?.queryItems = [
            URLQueryItem(name: APIConstants.cityKey, value: city),
            URLQueryItem(name: APIConstants.apiKey, value: apiKey),
            URLQueryItem(name: APIConstants.unitsKey, value: "metric")
        ]
        
        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
    
    func fetchCurrentWeather(request: URLRequest) async throws -> CurrentWeatherResponse {
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.httpStatus(code: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(CurrentWeatherResponse.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}

