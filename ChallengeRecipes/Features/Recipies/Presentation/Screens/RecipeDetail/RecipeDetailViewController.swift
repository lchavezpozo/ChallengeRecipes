//
//  RecipeDetailViewController.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//

import UIKit
import MapKit

class RecipeDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 20
        return sv
    }()

    private let imageDescriptionCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.UI.cornerRadius
        view.layer.borderWidth = Constants.UI.borderWidth
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.UI.lightGrayAlpha).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Constants.UI.shadowOpacity
        view.layer.shadowOffset = Constants.UI.shadowOffset
        view.layer.shadowRadius = Constants.UI.shadowRadius
        return view
    }()

    private lazy var recipeImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        iv.layer.cornerRadius = Constants.UI.cornerRadius
        iv.image = UIImage(named: viewModel.recipeImageName)
        return iv
    }()

    private let overlayView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = Constants.Colors.overlayBackgroundColor
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.layer.cornerRadius = Constants.UI.cornerRadius
        return v
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.titleLabelFont
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.alpha = 0
        label.text = viewModel.recipeName
        return label
    }()

    private let descriptionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.descriptionLabelFont
        label.textColor = Constants.Colors.descriptionTextColor
        label.numberOfLines = 0
        label.text = viewModel.recipeDescription
        return label
    }()

    private let ingredientsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        view.layer.cornerRadius = Constants.UI.cornerRadius
        view.layer.borderWidth = Constants.UI.borderWidth
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.UI.lightGrayAlpha).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Constants.UI.shadowOpacity
        view.layer.shadowOffset = Constants.UI.shadowOffset
        view.layer.shadowRadius = Constants.UI.shadowRadius
        return view
    }()

    private let ingredientsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.ingredientsTitleFont
        label.text = Constants.Texts.ingredientsTitle
        label.textColor = UIColor.systemOrange
        return label
    }()

    private lazy var ingredientsInfoLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = Constants.Fonts.ingredientsInfoFont
        lbl.numberOfLines = 0
        lbl.textColor = Constants.Colors.ingredientsTextColor
        lbl.text = viewModel.recipeIngredients
        return lbl
    }()

    private let preparationContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        view.layer.cornerRadius = Constants.UI.cornerRadius
        view.layer.borderWidth = Constants.UI.borderWidth
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(Constants.UI.lightGrayAlpha).cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = Constants.UI.shadowOpacity
        view.layer.shadowOffset = Constants.UI.shadowOffset
        view.layer.shadowRadius = Constants.UI.shadowRadius
        return view
    }()

    private let preparationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.preparationTitleFont
        label.text = Constants.Texts.preparationTitle
        label.textColor = UIColor.systemGreen
        return label
    }()

    private lazy var preparationInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.Fonts.preparationInfoFont
        label.numberOfLines = 0
        label.textColor = Constants.Colors.preparationTextColor
        label.text =  viewModel.recipePreparation
        return label
    }()

    private lazy var mapButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle(Constants.Texts.mapButtonTitle, for: .normal)
        btn.titleLabel?.font = Constants.Fonts.mapButtonFont
        btn.backgroundColor = UIColor.systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 12
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.3
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowRadius = 10
        btn.addTarget(self, action: #selector(didTapMapButton), for: .touchUpInside)
        return btn
    }()

    private let viewModel: RecipeDetailViewModel

    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) no ha sido implementado")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateUI()
    }

    private func animateUI() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.titleLabel.alpha = 1
        }
        animator.startAnimation(afterDelay: 0.1)

    }

    @objc private func didTapMapButton() {
        viewModel.handleDidTapMap()
    }
}

private extension RecipeDetailViewController {

    func setupUI() {
        view.backgroundColor = .systemGroupedBackground
        setupScrollView()
        setupContentStackView()
        setupImageDescriptionCard()
        setupIngredientsContainer()
        setupPreparationContainer()
        setupMapButton()
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupContentStackView() {
        scrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30)
        ])
    }

    func setupImageDescriptionCard() {
        contentStackView.addArrangedSubview(imageDescriptionCard)
        setupRecipeImageView()
        setupDescriptionContainer()
    }

    func setupRecipeImageView() {
        imageDescriptionCard.addSubview(recipeImageView)
        recipeImageView.addSubview(overlayView)
        recipeImageView.addSubview(titleLabel)

        setupRecipeImageViewConstraints()
        setupOverlayViewConstraints()
        setupTitleLabelConstraints()
    }

    func setupRecipeImageViewConstraints() {
        NSLayoutConstraint.activate([
            recipeImageView.topAnchor.constraint(equalTo: imageDescriptionCard.topAnchor),
            recipeImageView.leadingAnchor.constraint(equalTo: imageDescriptionCard.leadingAnchor),
            recipeImageView.trailingAnchor.constraint(equalTo: imageDescriptionCard.trailingAnchor),
            recipeImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30)
        ])
    }

    func setupOverlayViewConstraints() {
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: recipeImageView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor)
        ])
    }

    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: recipeImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: recipeImageView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: -4)
        ])
    }

    func setupDescriptionContainer() {
        imageDescriptionCard.addSubview(descriptionContainer)
        descriptionContainer.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor),
            descriptionContainer.leadingAnchor.constraint(equalTo: imageDescriptionCard.leadingAnchor),
            descriptionContainer.trailingAnchor.constraint(equalTo: imageDescriptionCard.trailingAnchor),
            descriptionContainer.bottomAnchor.constraint(equalTo: imageDescriptionCard.bottomAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainer.topAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor,
                                                      constant:  Constants.Layout.padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor,
                                                       constant: -Constants.Layout.padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionContainer.bottomAnchor, constant: -6)
        ])
    }

    func setupIngredientsContainer() {
        contentStackView.addArrangedSubview(ingredientsContainer)
        ingredientsContainer.addSubview(ingredientsTitleLabel)
        ingredientsContainer.addSubview(ingredientsInfoLabel)
        NSLayoutConstraint.activate([
            ingredientsTitleLabel.topAnchor.constraint(equalTo: ingredientsContainer.topAnchor,
                                                       constant: Constants.Layout.padding),
            ingredientsTitleLabel.leadingAnchor.constraint(equalTo: ingredientsContainer.leadingAnchor,
                                                           constant: Constants.Layout.padding),
            ingredientsTitleLabel.trailingAnchor.constraint(equalTo: ingredientsContainer.trailingAnchor,
                                                            constant: -Constants.Layout.padding),

            ingredientsInfoLabel.topAnchor.constraint(equalTo: ingredientsTitleLabel.bottomAnchor,
                                                      constant: Constants.Layout.spacingBetweenLabels),
            ingredientsInfoLabel.leadingAnchor.constraint(equalTo: ingredientsContainer.leadingAnchor,
                                                          constant: Constants.Layout.padding),
            ingredientsInfoLabel.trailingAnchor.constraint(equalTo: ingredientsContainer.trailingAnchor,
                                                           constant: -Constants.Layout.padding),
            ingredientsInfoLabel.bottomAnchor.constraint(equalTo: ingredientsContainer.bottomAnchor,
                                                         constant: -Constants.Layout.padding)
        ])
    }

    func setupPreparationContainer() {
        contentStackView.addArrangedSubview(preparationContainer)
        preparationContainer.addSubview(preparationTitleLabel)
        preparationContainer.addSubview(preparationInfoLabel)
        NSLayoutConstraint.activate([
            preparationTitleLabel.topAnchor.constraint(equalTo: preparationContainer.topAnchor,
                                                       constant: Constants.Layout.padding),
            preparationTitleLabel.leadingAnchor.constraint(equalTo: preparationContainer.leadingAnchor,
                                                           constant: Constants.Layout.padding),
            preparationTitleLabel.trailingAnchor.constraint(equalTo: preparationContainer.trailingAnchor,
                                                            constant: -Constants.Layout.padding),

            preparationInfoLabel.topAnchor.constraint(equalTo: preparationTitleLabel.bottomAnchor,
                                                      constant: Constants.Layout.spacingBetweenLabels),
            preparationInfoLabel.leadingAnchor.constraint(equalTo: preparationContainer.leadingAnchor,
                                                          constant: Constants.Layout.padding),
            preparationInfoLabel.trailingAnchor.constraint(equalTo: preparationContainer.trailingAnchor,
                                                           constant: -Constants.Layout.padding),
            preparationInfoLabel.bottomAnchor.constraint(equalTo: preparationContainer.bottomAnchor,
                                                         constant: -Constants.Layout.padding)
        ])
    }

    func setupMapButton() {
        contentStackView.addArrangedSubview(mapButton)
    }
 }
