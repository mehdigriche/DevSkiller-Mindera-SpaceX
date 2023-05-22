//
//  Launch.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation

struct Patch: Codable {
    let small: String?
}

struct Links: Codable {
    let patch: Patch?
    let webcast: String?
    let article: String?
    let wikipedia: String?
}
    
struct Launch: Codable {
    
    let name: String?
    let date_utc : String?
    let rocket: String?
    let links: Links?
    let success: Bool?
}
