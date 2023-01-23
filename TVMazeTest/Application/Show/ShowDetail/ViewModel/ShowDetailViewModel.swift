//
//  ShowDetailViewModel.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

class ShowDetailViewModel {

    private(set) var episodes: [Episode] = []
    private(set) var seasons: [Season] = []

    private var show: Show

    init(show: Show) {
        self.show = show
    }

    func getEpisodeList(completion: @escaping(Error?) -> Void) {

        let group = DispatchGroup()

        let route = RouteModel(path: ShowPath(path: .showEpisodes(showId: show.id ?? 0)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: [Episode].self) { [weak self] result, error in

            var episodes = result

            episodes.enumerated().forEach { index, episode in
                group.enter()
                self?.getEpisodeCover(with: episode.image?.original) { data, _ in

                    episodes[index].imageData = data
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self?.episodes = episodes
                completion(error)
            }
        }
    }

    func getSeasonList(completion: @escaping(Error?) -> Void) {

        let group = DispatchGroup()

        let route = RouteModel(path: ShowPath(path: .showSeasons(showId: show.id ?? 0)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: [Season].self) { [weak self] result, error in

            self?.seasons = result

            completion(error)
        }
    }

    private func getEpisodeCover(with url: String?, completion: @escaping(Data, Error?) -> Void) {

        let adapter = NetworkAdapter()

        adapter.request(with: url ?? "") { imageData, error in

            completion(imageData, error)
        }
    }
}
