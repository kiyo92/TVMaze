//
//  HomeCoordinator.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {

    weak var parent: Coordinator?
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {

        self.navigationController = navigationController
    }

    func start() {

        let vc = ShowListViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }

    func showDetail(show: Show) {

        let child = ShowCoordinator(navigationController: self.navigationController)
        child.parent = self
        children.append(child)
        child.start(with: show)
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
