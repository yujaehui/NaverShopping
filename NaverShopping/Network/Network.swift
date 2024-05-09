//
//  Network.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
}

final class Network {
    static let shared = Network()
    private init() {}
    
    func requestShoppingAPI(query: String, start: Int) async throws -> [Item] {
        guard var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/shop") else { throw NetworkError.invalidURL }
        urlComponents.queryItems = [URLQueryItem(name: "query", value: query),
                                    URLQueryItem(name: "start", value: "\(start)")]
        guard let url = urlComponents.url else { throw NetworkError.invalidURL }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-Naver-Client-Id" : APIKey.clientID,
                                       "X-Naver-Client-Secret" : APIKey.clientSecret]
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { throw NetworkError.invalidResponse }
        let decodedData = try JSONDecoder().decode(Shopping.self, from: data)
        return decodedData.items
    }
}

