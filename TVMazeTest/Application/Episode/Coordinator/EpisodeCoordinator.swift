//
//  EpisodeCoordinator.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 23/01/23.
//

import Foundation
import UIKit

class EpisodeCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {}

    func start(with episode: Episode) {

        let vc = EpisodeDetailViewController(episode: episode)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func dismiss(_ vc: UIViewController) {

        vc.dismiss(animated: true)
    }

    func dismissCoordinator() {

        let parent = self.parent as? ShowCoordinator
        parent?.dismissChildCoordinator(with: self)
    }
}
