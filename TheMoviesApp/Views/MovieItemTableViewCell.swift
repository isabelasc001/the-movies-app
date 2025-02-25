//
//  MovieItemTableViewCell.swift
//  TheMoviesApp
//
//  Created by Isabela da Silva Cardoso on 20/02/25.
//
//
import UIKit

class MovieItemTableViewCell: UITableViewCell {

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkText
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let overviewText: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = .darkText
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(movieImageView)
        stackView.addArrangedSubview(titleLabel)
        
        contentView.addSubview(overviewText)

        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: overviewText.topAnchor, constant: -10),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 80),
            movieImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            overviewText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            overviewText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            overviewText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }

    func configureCell(with movie: Movie) {
        titleLabel.text = movie.title
        overviewText.text = movie.overview
        let baseImageURL = "https://image.tmdb.org/t/p/w500"
        if let url = URL(string: baseImageURL + movie.posterPath) {
            movieImageView.loadImage(from: url)
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
