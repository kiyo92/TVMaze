//
//  InfoBadgeView.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

class InfoBadgeView: UIView {

    enum InfoBadgeType {

        case normal
        case info
        case warning
        case danger
    }

    var titleText: String {

        didSet {

            titleLabel.text = titleText
        }
    }

    var badgeType: InfoBadgeType

    private lazy var container: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private lazy var titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#8C8C8C")
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    convenience init(title: String, badgeType: InfoBadgeType) {

        self.init(frame: .zero)
        self.titleText = title
        self.badgeType = badgeType
        setupAdditionalConfiguration()
        setupHierarchy()
        setupConstraints()
    }

    override init(frame: CGRect) {

        self.titleText = ""
        self.badgeType = .normal
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        
        self.titleText = ""
        self.badgeType = .normal
        super.init(coder: coder)
    }

    func setupAdditionalConfiguration() {

        titleLabel.text = titleText
        container.layer.cornerRadius = 5
        switch badgeType {

        case .normal:
            container.backgroundColor = UIColor(hex: "#191919")
        default:
            // TODO: Create other styles
            container.backgroundColor = .systemBlue
        }
    }

    func setupHierarchy() {

        addSubview(container)
        container.addSubview(titleLabel)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            container.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),

            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -5),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
        ])
    }
}
