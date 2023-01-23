//
//  ShowPath.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

class ShowPath: PathProtocol {

    enum Path {

        case showList(page: Int)
        case showSeasons(showId: Int)
        case showEpisodes(showId: Int)
        case search(text: String)
    }

    let path: Path

    init(path: Path) {

        self.path = path
    }

    func getPath() -> String {

        switch path {

        case .showList(let page):
            return "https://api.tvmaze.com/shows?page=\(page)"

        case .showSeasons(showId: let showId):
            return "https://api.tvmaze.com/shows/\(showId)/seasons"

        case .showEpisodes(showId: let showId):
            return "https://api.tvmaze.com/shows/\(showId)/episodes"

        case .search(text: let text):
            return "https://api.tvmaze.com/search/shows?q=\(text)&embed=shows"
        }
    }
}
