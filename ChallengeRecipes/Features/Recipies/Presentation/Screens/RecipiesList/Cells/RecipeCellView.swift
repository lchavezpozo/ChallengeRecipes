//
//  RecipeCellView.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//
import UIKit

class RecipeCellView: UICollectionViewCell {
    static let identifier = "RecipeCellView"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var bottomContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurEffectView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe Title"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: RecipeCellViewModel) {
        imageView.image = UIImage(named: viewModel.imangeName)
        titleLabel.text = viewModel.name
    }
}

extension RecipeCellView {
    private func setupUI() {
        setupImageView()
        setupBottomContainer()
        setupBlurEffectView()
        setupTitleLabel()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupBottomContainer() {
        imageView.addSubview(bottomContainer)
        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
        ])
    }
    
    func setupBlurEffectView() {
        bottomContainer.addSubview(blurEffectView)
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: bottomContainer.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor)
        ])
    }
    private func setupTitleLabel() {
        bottomContainer.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomContainer.bottomAnchor)
        ])
    }
}


