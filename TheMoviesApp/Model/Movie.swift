//
//  Movies.swift
//  TheMoviesApp
//
//  Created by Isabela da Silva Cardoso on 20/02/25.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}

