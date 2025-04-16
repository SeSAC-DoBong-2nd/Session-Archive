//
//  Network.swift
//  SeSACSwiftUIBasic
//
//  Created by 박신영 on 4/16/25.
//

import Foundation
/// 싱글톤: class 기반 vs sturct 기반
///     -> 왜 struct로는 안 만들까?

enum APIError: Error {
    case invalidResponse
}

struct Market: Hashable, Codable, Identifiable {
    let id = UUID()
    let market, koreanName, englishName: String
    var like = false

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}

typealias Markets = [Market]

struct Network {
    
    static let shared = Network()
    
    private init() {}
    
    static func fetchAllMarket() async throws -> Markets {
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        let decodedData = try JSONDecoder().decode(Markets.self, from: data)
        return decodedData
    }
    
}
