//
//  Model.swift
//  MessariApp
//
//  Created by Офелия on 28.07.2021.
//

import Foundation
import UIKit


struct Welcome: Codable {
    var status: Status
    var data: [Asset]
}

// MARK: - Datum
struct Asset: Codable {
    var id, slug, symbol, name: String
    var metrics: Metrics
    var profile: Profile
}

// MARK: - Metrics
struct Metrics: Codable {
    var marketData: MarketData
    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
}

// MARK: - MarketData
struct MarketData: Codable {
    var priceUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let general: ProfileGeneral?
}

struct ProfileGeneral: Codable {
    let overview: GeneralOverview?
}

struct GeneralOverview: Codable {
    let tagline: String?
    let projectDetails: String?
    let officialLinks: [OfficialLink]?
    
    enum CodingKeys: String, CodingKey {
        case tagline
        case projectDetails = "project_details"
        case officialLinks = "official_links"
    }
}

struct OfficialLink: Codable {
    var name, link: String
}

// MARK: - Status
struct Status: Codable {
    var elapsed: Int
    var timestamp: String
}
