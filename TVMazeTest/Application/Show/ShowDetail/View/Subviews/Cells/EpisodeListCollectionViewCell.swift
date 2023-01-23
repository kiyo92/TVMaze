//
//  EpisodeListCollectionViewCell.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

class EpisodeListCollectionViewCell: UICollectionViewCell {

    var episode: Episode?
    lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    lazy var coverImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()

    var episodeNumberBadge: InfoBadgeView = {

        let view = InfoBadgeView(title: "EPISODE 1", badgeType: .normal)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    lazy var titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)

        return label
    }()

    lazy var subtitleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 3

        return label
    }()

    func setupData(episode: Episode) {

        self.episode = episode
        episodeNumberBadge.titleText = "EPISODE \(episode.number ?? 0)"
        titleLabel.text = episode.name ?? ""
        subtitleLabel.text = episode.summary?.htmlToString
        coverImageView.image = UIImage(data: episode.imageData ?? Data()) ?? UIImage()
    }

    override func layoutSubviews() {

        super.layoutSubviews()
        episodeNumberBadge.titleText = "EPISODE \(episode?.number ?? 0)"
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(container)
        container.addSubview(coverImageView)
        container.addSubview(episodeNumberBadge)
        container.addSubview(titleLabel)
        container.addSubview(subtitleLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            coverImageView.topAnchor.constraint(equalTo: container.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            coverImageView.heightAnchor.constraint(equalToConstant: 100),

            episodeNumberBadge.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 8),
            episodeNumberBadge.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            episodeNumberBadge.heightAnchor.constraint(equalToConstant: 30),

            titleLabel.topAnchor.constraint(equalTo: episodeNumberBadge.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),

        ])
    }
}
