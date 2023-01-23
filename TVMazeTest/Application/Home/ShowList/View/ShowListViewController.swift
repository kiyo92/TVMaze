//
//  ViewController.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 21/01/23.
//

import UIKit

class ShowListViewController: UIViewController {

    weak var coordinator: HomeCoordinator?
    var viewModel: ShowListViewModel = ShowListViewModel()
    var collectionView: UICollectionView = {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShowListHeaderCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SeriesListCollectionViewCell")

        return collectionView
    }()

    var tableView: UITableView = {

        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ShowListTableViewCell.self,
                           forCellReuseIdentifier: "SeriesListTableViewCell")
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0

        return tableView
    }()

    lazy var headerPageControl: UIPageControl = {

        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()

    lazy var loader: CustomLoadingView = {

        var loader = CustomLoadingView(parent: self.view)

        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(hex: "030303")
        collectionView.delegate = self
        collectionView.dataSource = self
        tableView.delegate = self
        tableView.dataSource = self
        setupHierarchy()
        setupConstraints()
        loader.popInLoader()
        collectionView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        viewModel.getShowList { [weak self] _ in

            self?.tableView.reloadData()
            self?.collectionView.reloadData()
            self?.loader.stopLoading()
        }
    }

    func setupHierarchy() {

        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(loader)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ShowListViewController: UICollectionViewDelegate,
                                        UICollectionViewDataSource,
                                        UICollectionViewDelegateFlowLayout {


    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if viewModel.showList.count > 0 {

            return 4
        }

         return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeriesListCollectionViewCell",
                                                            for: indexPath) as? ShowListHeaderCollectionViewCell
        else { return UICollectionViewCell() }

        cell.setupLayout()
        let randIndex = Int.random(in: 0...viewModel.showList.count - 1)
        cell.setupData(show: viewModel.showList[randIndex])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension ShowListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // TODO: Arrange by categories (genre)
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = ShowListTableViewHeader()
        header.setupLayout()

        return header
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesListTableViewCell", for: indexPath) as? ShowListTableViewCell else { return UITableViewCell() }

        cell.setupLayout()
        cell.showList = viewModel.showList
        cell.reloadCollectionView()
        cell.delegate = self

        return cell
    }
}

extension ShowListViewController: ShowListTableViewCellDelegate {

    func didSelectShow(show: Show) {

        coordinator?.showDetail(show: show)
    }
}
