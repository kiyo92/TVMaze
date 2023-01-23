//
//  Coordinator.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

public protocol Coordinator : AnyObject {

    var children: [Coordinator] { get set }

    var navigationController: UINavigationController { get set}

    func start()
}
