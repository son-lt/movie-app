//
//  ApiService.swift
//  movie-app
//
//  Created by TuanDQ on 21/02/2023.
//

import Foundation

class ApiService {
    static let shareInstance = ApiService()

    
    func getPopularMovieList(page: Int, onSuccess: @escaping ((PopularMovieList?) -> Void), onFailure: @escaping (String) -> Void){
        let url = URL(string: Configs.Network.apiBaseUrl + "movie/popular?" + "api_key=\(Configs.Network.apiKey)" + "&page=\(page)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if error != nil || data == nil {
                    print("Client error!")
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }

                do {
                    let result = try JSONDecoder().decode(PopularMovieList.self, from: data!)
                    onSuccess(result)
                } catch {
                    onFailure("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
    
    func getUpcomingMovieList(page: Int, onSuccess: @escaping ((UpcomingMovieList?) -> Void), onFailure: @escaping (String) -> Void){
        let url = URL(string: Configs.Network.apiBaseUrl + "movie/upcoming?" + "api_key=\(Configs.Network.apiKey)" + "&page=\(page)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if error != nil || data == nil {
                    print("Client error!")
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }

                do {
                    let result = try JSONDecoder().decode(UpcomingMovieList.self, from: data!)
                    onSuccess(result)
                } catch {
                    onFailure("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
    
    func getCastList(ID: Int, onSuccess: @escaping ((CastList?) -> Void), onFailure: @escaping (String) -> Void) {
        let url = URL(string: Configs.Network.apiBaseUrl + "movie/\(ID)/credits?" + "api_key=\(Configs.Network.apiKey)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if error != nil || data == nil {
                    print("Client error!")
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }

                do {
                    let result = try JSONDecoder().decode(CastList.self, from: data!)
                    onSuccess(result)
                } catch {
                    onFailure("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
    
    func getGenreList(onSuccess: @escaping ((GenreList?) -> Void), onFailure: @escaping (String) -> Void) {
        let url = URL(string: Configs.Network.apiBaseUrl + "genre/movie/list" + "?api_key=\(Configs.Network.apiKey)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            if error != nil || data == nil {
                    print("Client error!")
                    return
                }

                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }

                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }

                do {
                    let result = try JSONDecoder().decode(GenreList.self, from: data!)
                    onSuccess(result)
                } catch {
                    onFailure("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
}


