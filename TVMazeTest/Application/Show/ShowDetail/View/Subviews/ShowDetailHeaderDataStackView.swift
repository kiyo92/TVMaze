//
//  ShowDetailHeaderDataStackView.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

class ShowDetailHeaderDataStackView: UIStackView {

    convenience init(views: [UIView]) {
        self.init(frame: .zero)
        distribution = .fillEqually
        axis = .horizontal
        spacing = 4
        
        views.forEach { view in
            addArrangedSubview(view)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
