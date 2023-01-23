//
//  Show.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

struct Show: Codable {
    var id: Int?
    var name: String?
    var schedule: Schedule?
    var genres: [String]?
    var summary: String?
    var image: Image?
    var imageData: Data?
}

struct Schedule: Codable {
    var time: String?
    var days: [String]?
}
struct Image: Codable {
    var medium, original: String
}

struct ShowSearch: Codable {
    var show: Show?
}
