//
//  Configs.swift
//  movie-app
//
//  Created by TuanDQ on 21/02/2023.
//

import Foundation

struct Configs {
    
    struct Network {
           static let apiBaseUrl = "https://api.themoviedb.org/3/movie/"
           static let apiKey = "26763d7bf2e94098192e629eb975dab0"
       }
    
    struct BaseDimensions {
        static let inset: CGFloat = 10
        static let tabBarHeight: CGFloat = 58
        static let toolBarHeight: CGFloat = 66
        static let navBarWithStatusBarHeight: CGFloat = 64
        static let cornerRadius: CGFloat = 5
        static let borderWidth: CGFloat = 1
        static let buttonHeight: CGFloat = 40
        static let textFieldHeight: CGFloat = 40
        static let tableRowHeight: CGFloat = 40
        static let segmentedControlHeight: CGFloat = 40
    }
}
