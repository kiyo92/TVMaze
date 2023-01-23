//
//  ShowSeasonListViewController.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

protocol ShowSeasonListDelegate: AnyObject {

    func didSelectedSeason(season: Int)
}

class ShowSeasonListViewController: UIViewController {

    let seasons: [Season]

    weak var delegate: ShowSeasonListDelegate?

    private var selectedSeason = 0

    let container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        return view
    }()
    let stackView: UIStackView = {

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        return stackView
    }()

    init(seasons: [Season]) {

        self.seasons = seasons
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupConstraints()
        populateStackView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
    }

    func populateStackView() {

        var splitedSeasons: [[Season]] = []
        var tempSeason: [Season] = []
        seasons.enumerated().forEach { index, season in

            tempSeason.append(season)
            if (index + 1) % 4 == 0 {
                splitedSeasons.append(tempSeason)
                tempSeason = []
            }

            if seasons.last?.number == season.number {

                splitedSeasons.append(tempSeason)
            }
        }

        splitedSeasons.forEach { seasons in

            var badges: [InfoBadgeView] = []
            seasons.forEach { season in
                let badge = InfoBadgeView(title: "Season \(season.number ?? 0)", badgeType: .normal)
                let tap = UITapGestureRecognizer(target: self,
                                                 action: #selector(didSelectedSeason(sender:)))
                badge.tag = season.number ?? 0
                badge.addGestureRecognizer(tap)
                badge.layer.cornerRadius = 5
                badges.append(badge)
            }
            stackView.addArrangedSubview(ShowDetailHeaderDataStackView(views: badges))
            badges = []
        }
    }

    @objc
    func didSelectedSeason(sender: UITapGestureRecognizer) {

        guard let season = sender.view?.tag else { return }

        delegate?.didSelectedSeason(season: season)
        self.dismiss(animated: true)
    }

    func setupHierarchy() {

        view.addSubview(container)
        container.addSubview(stackView)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: container.topAnchor, constant: 32),
            stackView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
        ])
    }
}
