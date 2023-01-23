//
//  ShowListViewModel.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import Foundation

class ShowListViewModel {

    private var currentPage: Int = 0
    private(set) var showList: [Show] = []
    
    // TODO: Arrange in categories
    private(set) var arrangedShowList: [[Show]] = []

    func getShowList(completion: @escaping(Error?) -> Void) {

        let group = DispatchGroup()

        let route = RouteModel(path: ShowPath(path: .showList(page: self.currentPage)))
        let adapter = NetworkAdapter(route: Router(route: route))

        adapter.request(with: [Show].self) { [weak self] result, error in

            var shows = result

            shows.enumerated().forEach { index, show in
                group.enter()
                self?.getShowCover(with: show.image?.medium) { data, _ in

                    shows[index].imageData = data
                    group.leave()
                }
            }

            group.notify(queue: .main) {
                self?.showList.append(contentsOf: shows)
                completion(error)
            }
        }
    }

    private func getShowCover(with url: String?, completion: @escaping(Data, Error?) -> Void) {

        let adapter = NetworkAdapter()

        adapter.request(with: url ?? "") { imageData, error in

            completion(imageData, error)
        }
    }
}
