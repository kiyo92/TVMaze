//
//  SeriesListTableViewHeader.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 22/01/23.
//

import UIKit

class ShowListTableViewHeader: UIView {

    let titleLabel: UILabel = {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popular Series"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white

        return label
    }()

    let continueButton: UIButton = {

        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(hex: "#191919")
        button.layer.cornerRadius = 15

        return button
    }()


    func setupLayout() {

        backgroundColor = UIColor(hex: "030303")
        setupHierarchy()
        setupConstraints()
    }

    func setupHierarchy() {

        addSubview(titleLabel)
        addSubview(continueButton)
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            titleLabel.trailingAnchor.constraint(equalTo: continueButton.leadingAnchor, constant: 16),

            continueButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            continueButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 30),
            continueButton.widthAnchor.constraint(equalToConstant: 30),
        ])
    }
}
