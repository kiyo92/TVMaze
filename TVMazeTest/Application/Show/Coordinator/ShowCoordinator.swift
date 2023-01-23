//
//  ShowCoordinator.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation
import UIKit

class ShowCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {}

    func start(with show: Show) {

        let viewModel = ShowDetailViewModel(show: show)
        let vc = ShowDetailViewController(show: show, viewModel: viewModel)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func showSeasonSelector(with seasons: [Season], origin: ShowDetailViewController) {

        let vc = ShowSeasonListViewController(seasons: seasons)
        vc.preferredContentSize = .init(width: 500, height: 800)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.delegate = origin
        self.navigationController.present(vc, animated: true, completion: nil)
    }

    func showEpisodeDetail(episode: Episode) {

        let child = EpisodeCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.start(with: episode)
    }

    func dismiss(_ vc: UIViewController) {

        vc.dismiss(animated: true)
    }

    func dismissCoordinator() {

        let parent = self.parent as? HomeCoordinator
        parent?.dismissChildCoordinator(with: self)
    }

    func dismissChildCoordinator (with child: Coordinator?) {

        for (index, coordinator) in children.enumerated() {

            if child === coordinator {

                children.remove(at: index)
                break
            }
        }
    }
}
