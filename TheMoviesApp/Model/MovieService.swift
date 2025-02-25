//
//  MovieService.swift
//  TheMoviesApp
//
//  Created by Isabela da Silva Cardoso on 20/02/25.
//

import UIKit


class MovieService {
    
    private let apiKey = "57950f49f3f9f91d03ef045d300508f3"
    
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"
    
    func fetchMoviesData(completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(baseURL)?api_key=\(apiKey)&language=pt-BR&page=1"
        
        guard let url = URL(string: urlString) else {
            print("Erro: URL inválida")
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Erro: dados vazios")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                        print("JSON Recebido: \(jsonString)")
                    }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Erro ao decodificar JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        task.resume()
    }
}
