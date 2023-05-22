//
//  APIRequest.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case invalidUrl
    case invalidData
}

func APIRequest<T: Codable>(from url: URL?, rocketID: String? = nil, completion: @escaping (Result<T, Error>) -> Void) {
    
    guard let url = url else {
        completion(.failure(CustomError.invalidUrl))
        return
    }
    
    let rocketUrl = url.appendingPathComponent(rocketID ?? "")
    
    let task = URLSession.shared.dataTask(with: rocketUrl) { (data, response, error) in
        guard let data = data else {
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.failure(CustomError.invalidData))
            }
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}
