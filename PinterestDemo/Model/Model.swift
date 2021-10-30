//
//  Model.swift
//  PinterestDemo
//
//  Created by Łukasz Jakubek on 29/06/2021.
//

import Foundation

struct ApiResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}
