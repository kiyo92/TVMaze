//
//  Router.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation
import Alamofire

class Router: RouteProtocol {

    private let route: RouteModel

    init(route: RouteModel) {

        self.route = route
    }

    func getRoute() -> RouteModel {

        return self.route
    }
}
