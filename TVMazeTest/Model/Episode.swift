//
//  Episode.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

struct Episode: Codable {
    var id: Int?
    var name: String?
    var number: Int?
    var season: Int?
    var summary: String?
    var runtime: Int?
    var image: Image?
    var imageData: Data?
}
