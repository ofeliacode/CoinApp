//
//  Networking.swift
//  MessariApp
//
//  Created by Офелия on 29.07.2021.
//

import Foundation

protocol NetworkingProtocol {
    func loadData(_ page: Int, completion: @escaping (Result<[Asset], Error>) -> Void)
}

class Networking: NetworkingProtocol {
    
    enum APIError: Error {
        case invalidUrl
    }
    
    public func loadData(_ page: Int, completion: @escaping (Result<[Asset], Error>) -> Void) {
        let urlString = "https://data.messari.io/api/v2/assets?with-metrics&page=\(page)&limit=20"

        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidUrl))
            return
        }
   
        var request = URLRequest(url: url)
              request.setValue("3863a49e-93c5-4047-9110-182e2c95c33d", forHTTPHeaderField: "x-messari-api-key")
              request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
           
            guard let data = data else { return }
            if let json =  String(data: data, encoding: .utf8) {
                print("json \(json)")
            }
            do {
                let response = try JSONDecoder().decode(Welcome.self, from: data)
                completion(.success(response.data))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
   
}


