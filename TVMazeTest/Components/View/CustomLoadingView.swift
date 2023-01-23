//
//  CustomLoadingView.swift
//  TVMazeTest
//
//  Created by Joao Marcus Dionisio Araujo on 23/01/23.
//

import UIKit

class CustomLoadingView: UIView {

    private lazy var loadingIndicator: UIActivityIndicatorView = {

        let loading = UIActivityIndicatorView(style: .large)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.color = .white
        loading.hidesWhenStopped = true

        return loading
    }()

    convenience init(parent: UIView) {

        self.init(frame: .zero)
        setupAdditionalConfiguration()
        setupHierarchy()
        loadingIndicator.startAnimating()
        backgroundColor = UIColor(white: 0.2, alpha: 0.9)
        layer.cornerRadius = 5.0
        center = parent.center
        alpha = 0
        frame = CGRect(x: 0.0, y: 0.0,
                       width: parent.bounds.width,
                       height: parent.bounds.height)
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }

    override init(frame: CGRect) {

        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
    }

    func popInLoader() {
        loadingIndicator.startAnimating()
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseOut,
                       animations: {

            self.alpha = 1
            self.isHidden = false
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)

        }, completion: nil)
    }

    private func popOut() {

        UIView.animate(withDuration: 0.5,
                       delay: 1.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 5,
                       options: .curveEaseOut,
                       animations: {

            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        }, completion: nil)
    }

    func stopLoading() {

        loadingIndicator.stopAnimating()
        isHidden = true
        popOut()
    }

    private func setupAdditionalConfiguration() {

        addSubview(loadingIndicator)
    }

    private func setupHierarchy() {

        NSLayoutConstraint.activate([

            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
