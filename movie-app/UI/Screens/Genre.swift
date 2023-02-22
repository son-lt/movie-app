//
//  Genre.swift
//  movie-app
//
//  Created by TuanDQ on 22/02/2023.
//

import Foundation

// MARK: - GenreList
struct GenreList: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

