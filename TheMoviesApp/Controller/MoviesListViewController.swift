//
//  ViewController.swift
//  TheMoviesApp
//
//  Created by Isabela da Silva Cardoso on 18/02/25.
//

import UIKit

class MoviesListViewController: UIViewController {
    
    private let movieService = MovieService()
    private var movies: [Movie] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieItemTableViewCell.self, forCellReuseIdentifier: "MovieItemCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Lista de Filmes"
        view.backgroundColor = .systemBlue
        
        fetchMovies()
        setupTableView()
    }
    
    // MARK: - Setup UI
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
            
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchMovies() {
        movieService.fetchMoviesData { [weak self] movies in
            guard let self = self, let movies = movies else {
                print("Nenhum filme foi carregado.")
                return
            }
            self.movies = movies
            print("Filmes carregados: \(self.movies.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Número de filmes na tabela: \(movies.count)")
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieItemCell", for: indexPath) as? MovieItemTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        print("Configurando célula para: \(movie.title)")
        cell.configureCell(with: movie)
        return cell
     }
}
