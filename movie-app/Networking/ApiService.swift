//
//  ApiService.swift
//  movie-app
//
//  Created by TuanDQ on 21/02/2023.
//

import Foundation

class ApiService {
    static let shareInstance = ApiService()

    
    func getPopularMovieList(page: Int) -> Void {
        let url = URL(string: Configs.Network.apiBaseUrl + "popular?" + "api_key=\(Configs.Network.apiKey)" + "&page=\(page)")!
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
                    for i in 0...2 {
                        print(result.results[i].title)
                    }
                } catch {
                    print("JSON error: \(error)")
                }
            }
        )
        task.resume()
    }
    
    func getUpcomingMovieList(page: Int) -> Void {
        let url = URL(string: Configs.Network.apiBaseUrl + "upcoming?" + "api_key=\(Configs.Network.apiKey)" + "&page=\(page)")!
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
                    for i in 0...2 {
                        print(result.results[i].title)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
    
    func getCastList(ID: Int) -> Void {
        let url = URL(string: Configs.Network.apiBaseUrl + "\(ID)/credits?" + "api_key=\(Configs.Network.apiKey)")!
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
                    for i in 0...2 {
                        print(result.cast[i].name)
                    }
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
        )
        task.resume()
    }
}


