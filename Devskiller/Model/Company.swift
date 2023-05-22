//
//  Company.swift
//  Devskiller
//
//  Created by GRICHE, MEHDI on 21/5/2023.
//  Copyright © 2023 Mindera. All rights reserved.
//

import Foundation

struct Company: Codable {
    let name : String
    let founder : String
    let founded : Int
    let employees : Int
    let launch_sites : Int
    let valuation : Int
}
