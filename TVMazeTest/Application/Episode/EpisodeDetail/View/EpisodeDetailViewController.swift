//
//  EpisodeDetailViewController.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 23/01/23.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    var coordinator: EpisodeCoordinator?
    var episode: Episode

    lazy var scrollView: UIScrollView = {

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .clear

        return scrollView
    }()

    lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    lazy var headerContainer: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()

    lazy var showPosterImageView: UIImageView = {

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    lazy var verticalTitleDataStackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    lazy var playButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)

        return button
    }()

    let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8

        return stackView
    }()

    lazy var showDescription: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = ""
        label.textColor = .white
        label.layer.shadowRadius = 0.2
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5

        return label
    }()

    lazy var descriptionLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white

        return label
    }()

    init(episode: Episode) {

        self.episode = episode

        super.init(nibName: nil, bundle: nil)

        playButton.setTitle("Play Now", for: .normal)
        showPosterImageView.image = UIImage(data: episode.imageData ?? Data()) ?? UIImage()
        descriptionLabel.text = episode.summary?.htmlToString ?? ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        view.backgroundColor = UIColor(hex: "030303")
        setupHierarchy()
        setupConstraints()
        setTitleStackData()
    }

    private func setTitleStackData() {

        let nameLabel = UILabel()
        nameLabel.text = episode.name ?? ""
        nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        nameLabel.textAlignment = .right
        nameLabel.textColor = .white
        nameLabel.layer.shadowRadius = 0.2
        nameLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        nameLabel.layer.shadowOpacity = 0.5

        let runtimeLabel = UILabel()
        runtimeLabel.text = "\(episode.runtime ?? 0)min"
        runtimeLabel.textColor = .white
        runtimeLabel.layer.shadowRadius = 0.2
        runtimeLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        runtimeLabel.layer.shadowOpacity = 0.5

        let numberLabel = UILabel()
        numberLabel.text = "E: \(episode.number ?? 0)"
        numberLabel.textColor = .white
        numberLabel.textAlignment = .right
        numberLabel.layer.shadowRadius = 0.2
        numberLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        numberLabel.layer.shadowOpacity = 0.5

        let seasonLabel = UILabel()
        seasonLabel.text = "S: \(episode.season ?? 0)"
        seasonLabel.textColor = .white
        seasonLabel.layer.shadowRadius = 0.2
        seasonLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        seasonLabel.layer.shadowOpacity = 0.5

        stackView.addArrangedSubview(ShowDetailHeaderDataStackView(views: [nameLabel, runtimeLabel]))
        stackView.addArrangedSubview(ShowDetailHeaderDataStackView(views: [numberLabel, seasonLabel]))
    }

    private func setupHierarchy() {

        view.addSubview(scrollView)
        scrollView.addSubview(container)
        container.addSubview(headerContainer)
        headerContainer.addSubview(showPosterImageView)
        headerContainer.addSubview(verticalTitleDataStackView)
        headerContainer.addSubview(playButton)
        headerContainer.addSubview(stackView)
        headerContainer.addSubview(showDescription)
        container.addSubview(descriptionLabel)
    }

    private func setupConstraints() {

        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
                (self.navigationController?.navigationBar.frame.height ?? 0.0)
        NSLayoutConstraint.activate([

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: -topBarHeight),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            container.topAnchor.constraint(equalTo: scrollView.topAnchor),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor),

            headerContainer.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            headerContainer.topAnchor.constraint(equalTo: container.topAnchor),
            headerContainer.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5),

            showPosterImageView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            showPosterImageView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            showPosterImageView.topAnchor.constraint(equalTo: headerContainer.topAnchor),
            showPosterImageView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor),

            verticalTitleDataStackView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            verticalTitleDataStackView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            verticalTitleDataStackView.bottomAnchor.constraint(equalTo: playButton.topAnchor,
                                                               constant: -16),

            playButton.centerXAnchor.constraint(equalTo: headerContainer.centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: showDescription.topAnchor,
                                               constant: -16),
            playButton.heightAnchor.constraint(equalToConstant: 45),

            stackView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor,
                                                    constant: -16),

            descriptionLabel.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),

        ])
    }
}
