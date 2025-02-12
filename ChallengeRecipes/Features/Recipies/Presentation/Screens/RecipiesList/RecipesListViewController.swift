//
//  RecipesListViewController.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

import UIKit

class RecipesListViewController: UIViewController {
    // MARK: - UI Components
    private lazy var collectionLayout: UICollectionViewCompositionalLayout = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = RecipesListSection(rawValue: sectionIndex)
            return section?.getSectionLayout()
        }
        return layout
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        return cv
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<RecipesListSection, RecipesItem> = {
        let cellRegistration = UICollectionView.CellRegistration<RecipeCellView, RecipesItem> { [weak self] cell, indexPath, item in
            cell.configure(with: item.viewModel)
        }

        let dataSource = UICollectionViewDiffableDataSource<RecipesListSection, RecipesItem>(collectionView: collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        return dataSource
    }()
    
    private let loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorResultView: ErrorResultView = {
        let view = ErrorResultView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.onTapRetryButton = { [weak self] in
            self?.getRecipes()
        }
        return view
    }()
    
    // MARK: - Properties
    private var viewModel: RecipesListViewModel

    init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        getRecipes()
    }

    // MARK: - UI Updates
    private func setupBinding() {
        viewModel.didLoadRecipes = { [weak self] recipesItems in
            self?.applySnapshot(recipesItems)
        }
        
        viewModel.didTogleLoadView = { [weak self] showLoading in
            self?.toggleErrorResultView(false)
            self?.togleLoadingView(showLoading)
        }
        
        viewModel.didToggleSearchEmptyResultView = { [weak self] isEmpty in
            self?.toggleSearchResultEmptyStateView(isEmpty)
        }
        
        viewModel.didErrorResult = { [weak self] in
            self?.toggleErrorResultView(true)
        }
    }
    
    // MARK: - Data Handling
    private func getRecipes() {
        Task {
            await viewModel.getRecipes()
        }
    }

    private func applySnapshot(_ recipesItems: [RecipesItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<RecipesListSection, RecipesItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipesItems)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func togleLoadingView(_ shouldShow: Bool) {
        if shouldShow {
            loadingView.startLoading(parentView: view)
        } else {
            loadingView.stopLoading()
        }
    }
    
    private func toggleSearchResultEmptyStateView(_ shouldShow: Bool) {
        if shouldShow {
            let emptyView = SearchResultEmptyStateView()
            collectionView.backgroundView = emptyView
        } else {
            collectionView.backgroundView = nil
        }
    }
    
    private func toggleErrorResultView(_ shouldShow: Bool) {
        if shouldShow {
            errorResultView.removeFromSuperview()
            view.addSubview(errorResultView)
            NSLayoutConstraint.activate([
                errorResultView.topAnchor.constraint(equalTo: view.topAnchor),
                errorResultView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                errorResultView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                errorResultView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        } else {
            errorResultView.removeFromSuperview()
        }
    }
}

extension RecipesListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.handleDidTapRecipe(index: indexPath.row)
    }
}

extension RecipesListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        viewModel.searchRecipes(query: query)
    }
}

// MARK: - Setup Methods
private extension RecipesListViewController {
    func setupUI() {
        setupNavigationController()
        setupStyle()
        setupCollectionView()
    }
    
    private func setupNavigationController() {
        title = "Recetas"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar receta por nombre o ingrediente"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    func setupStyle() {
        view.backgroundColor = .white
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
