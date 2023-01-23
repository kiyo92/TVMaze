//
//  RouterModel.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation
import Alamofire

struct RouteModel {

    var method: HTTPMethod = .get
    let path: PathProtocol
    let parameters: Parameters? = nil
}
