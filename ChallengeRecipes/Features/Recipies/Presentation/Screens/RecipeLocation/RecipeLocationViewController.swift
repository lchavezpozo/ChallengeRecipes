//
//  RecipeLocationViewController.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//

import UIKit

class RecipeLocationViewController: UIViewController {
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✖", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray.withAlphaComponent(0.5)
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: RecipeLocationViewModel
    private let mapView: YapeMapView

    init(viewModel: RecipeLocationViewModel, mapView: YapeMapView = YapeMapViewModule.createMap()) {
        self.viewModel = viewModel
        self.mapView = mapView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureMapView()
    }

    private func configureMapView() {
        mapView.addMarker(at: viewModel.recipeLocation, title: viewModel.recipeTitle)
        mapView.setLocation(viewModel.recipeLocation, animated: true)
    }

    @objc
    private func didTapCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension RecipeLocationViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        setupMapView()
        setupButton()
    }

    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupButton() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
