//
//  ShowDetailViewController.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

class ShowDetailViewController: UIViewController {

    let show: Show
    var coordinator: ShowCoordinator?
    var viewModel: ShowDetailViewModel

    var selectedSeason = 1
    var filteredEpisodes: [Episode] = []
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
        button.setTitle("Season 1, Episode 1", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)

        return button
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

    lazy var episodesLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = "Episodes"
        label.textColor = .white

        return label
    }()

    lazy var seasonSelectButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Season 1", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,left: 10,bottom: 0,right: 0)
        button.addTarget(self, action: #selector(openSeasonSelector), for: .touchUpInside)

        return button
    }()

    lazy var collectionView: UICollectionView = {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 250)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(EpisodeListCollectionViewCell.self,
                                forCellWithReuseIdentifier: "EpisodeListCollectionViewCell")
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    lazy var loader: CustomLoadingView = {

        var loader = CustomLoadingView(parent: self.view)

        return loader
    }()

    init(show: Show, viewModel: ShowDetailViewModel) {

        self.show = show
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        showDescription.text = show.summary?.htmlToString
        showPosterImageView.image = UIImage(data: show.imageData ?? Data()) ?? UIImage()
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
        collectionView.delegate = self
        collectionView.dataSource = self

        getSeasonEpisodes(firstTime: true)
    }

    private func getSeasonEpisodes(firstTime: Bool = false) {

        self.loader.popInLoader()
        let group = DispatchGroup()

        group.enter()
        viewModel.getEpisodeList { _ in

            group.leave()
        }

        group.enter()
        viewModel.getSeasonList { _ in

            group.leave()
        }

        group.notify(queue: .main) { [weak self] in

            if firstTime {
                let currentSeason = self?.viewModel.seasons.first?.number ?? 1
                self?.filteredEpisodes = self?.viewModel.episodes.filter { $0.season == currentSeason } as? [Episode] ?? []

            } else {
                self?.filteredEpisodes = self?.viewModel.episodes.filter {

                    $0.season == self?.selectedSeason
                } as? [Episode] ?? []
            }
            self?.loader.stopLoading()
            self?.collectionView.reloadData()
        }
    }

    @objc
    private func openSeasonSelector() {

        coordinator?.showSeasonSelector(with: viewModel.seasons, origin: self)
    }

    private func setupHierarchy() {

        view.addSubview(scrollView)
        view.addSubview(loader)
        scrollView.addSubview(container)
        container.addSubview(headerContainer)
        headerContainer.addSubview(showPosterImageView)
        headerContainer.addSubview(verticalTitleDataStackView)
        headerContainer.addSubview(playButton)
        headerContainer.addSubview(showDescription)
        container.addSubview(episodesLabel)
        container.addSubview(seasonSelectButton)
        container.addSubview(collectionView)
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

            showDescription.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 32),
            showDescription.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -32),
            showDescription.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor,
                                                    constant: -16),

            episodesLabel.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 16),
            episodesLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),

            seasonSelectButton.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 16),
            seasonSelectButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            seasonSelectButton.widthAnchor.constraint(equalToConstant: 100),

            collectionView.topAnchor.constraint(equalTo: episodesLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}

extension ShowDetailViewController: UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

         return filteredEpisodes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeListCollectionViewCell",
                                                            for: indexPath) as? EpisodeListCollectionViewCell else { return UICollectionViewCell() }

        cell.setupData(episode: filteredEpisodes[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        coordinator?.showEpisodeDetail(episode: filteredEpisodes[indexPath.item])
    }

    func collectionView(_ collectionView: UICollectionView,
                        collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 200, height: 250)
    }
}

extension ShowDetailViewController: ShowSeasonListDelegate {

    func didSelectedSeason(season: Int) {
        selectedSeason = season
        seasonSelectButton.setTitle("Season \(season)", for: .normal)
        getSeasonEpisodes()
    }
}
