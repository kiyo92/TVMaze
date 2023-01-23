//
//  SeriesListCollectionViewCell.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 21/01/23.
//

import UIKit

class ShowListHeaderCollectionViewCell: UICollectionViewCell {

    lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var headerImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    lazy var headerTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 38, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.layer.shadowRadius = 0.2
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        return label
    }()

    lazy var headerSubtitleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        label.textAlignment = .center
        label.textColor = .white
        label.layer.shadowRadius = 0.2
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupData(show: Show) {

        headerImageView.image = UIImage(data: show.imageData ?? Data()) ?? UIImage()
        headerTitleLabel.text = show.name
        headerSubtitleLabel.text = show.summary?.htmlToString
    }

    func setupLayout() {

        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(container)
        contentView.addSubview(headerImageView)
        contentView.addSubview(headerTitleLabel)
        contentView.addSubview(headerSubtitleLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            headerImageView.topAnchor.constraint(equalTo: container.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            headerTitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            headerTitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            headerTitleLabel.bottomAnchor.constraint(equalTo: headerSubtitleLabel.topAnchor, constant: -8),

            headerSubtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 32),
            headerSubtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -32),
            headerSubtitleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -32),
        ])
    }
}
