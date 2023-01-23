//
//  SeriesListTableViewCell.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 21/01/23.
//

import UIKit

protocol ShowListTableViewCellDelegate: AnyObject {

    func didSelectShow(show: Show)
}

class ShowListTableViewCell: UITableViewCell {

    var showList: [Show] = []
    weak var delegate: ShowListTableViewCellDelegate?

    lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        return view
    }()

    var collectionView: UICollectionView = {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShowListCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SeriesListCollectionViewCell")
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupLayout() {

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        contentView.addSubview(container)
        contentView.addSubview(collectionView)

    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            collectionView.topAnchor.constraint(equalTo: container.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 260),
        ])
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension ShowListTableViewCell: UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout,
                                   UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return showList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesListCollectionViewCell",
                                                            for: indexPath) as? ShowListCollectionViewCell else { return UICollectionViewCell() }

        cell.setupLayout()
        cell.setupData(show: showList[indexPath.item])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 140, height: 280)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegate?.didSelectShow(show: showList[indexPath.item])
    }
}
