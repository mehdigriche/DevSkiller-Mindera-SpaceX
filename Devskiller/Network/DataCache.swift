//
//  DataManager.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation

class DataCache {
    private let userDefaults = UserDefaults.standard
    
    func save<T: Encodable>(key: String, data: T) {
        do {
            let encodedData = try JSONEncoder().encode(data)
            userDefaults.set(encodedData, forKey: key)
        } catch {
            print("Failed to encode data for \(key): \(error.localizedDescription)")
        }
    }
    
    func load<T: Decodable>(key: String) -> T? {
        guard let encodedData = userDefaults.data(forKey: key) else {
            return nil
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: encodedData)
            return decodedData
        } catch {
            print("Failed to decode data for key \(key): \(error.localizedDescription)")
            return nil
        }
    }
    
    func clearCache() {
        // Remove all cached data from UserDefaults
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        userDefaults.synchronize()
    }
}
