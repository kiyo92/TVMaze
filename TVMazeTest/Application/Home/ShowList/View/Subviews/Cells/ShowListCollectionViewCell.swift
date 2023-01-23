//
//  SeriesListCollectionViewCell.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 21/01/23.
//

import UIKit

class ShowListCollectionViewCell: UICollectionViewCell {

    lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    lazy var coverImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bleachCover")
        imageView.layer.masksToBounds = true
        return imageView
    }()

    lazy var titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white

        return label
    }()

    lazy var genreLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(show: Show) {
        coverImageView.image = UIImage(data: show.imageData ?? Data()) ?? UIImage()
        titleLabel.text = show.name ?? ""
        genreLabel.text = show.genres?.first ?? ""
    }

    func setupLayout() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

    func setupAdditionalConfiguration() {

        coverImageView.layer.cornerRadius = 10
    }

    func setupHierarchy() {

        contentView.addSubview(container)
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            coverImageView.topAnchor.constraint(equalTo: container.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 200),

            titleLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            genreLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            genreLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),

        ])
    }
}
