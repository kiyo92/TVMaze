//
//  AppDelegate.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 21/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: HomeCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        let navController = UINavigationController()

        self.coordinator = HomeCoordinator(navigationController: navController)

        self.coordinator?.start()

        self.window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = navController

        self.window?.makeKeyAndVisible()

        return true
    }
}

