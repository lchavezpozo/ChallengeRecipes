//
//  RecipeCoordinator.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//
import UIKit

@MainActor
protocol Coordinator {
    func start()
}

protocol RecipeDetailCoordinatorDelegate: AnyObject {
    func handleDidTapOrigin(_ recipe: Recipe)
}

protocol RecipeListCoordinatorDelegate: AnyObject {
    func handleDidTapRecipe(_ recipe: Recipe)
}

class RecipeCoordinator: Coordinator {
    private let window: UIWindow
    private let getRecipesAction: GetRecipesAction
    private weak var navigationController: UINavigationController?

    init(window: UIWindow, getRecipesAction: GetRecipesAction) {
        self.window = window
        self.getRecipesAction = getRecipesAction
    }

    func start() {
        let viewModel = RecipesListViewModelDefault(getRecipeAction: getRecipesAction,
                                                    coordinator: self)
        let vc = RecipesListViewController(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: vc)
        navigationController = nav
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

extension RecipeCoordinator: RecipeListCoordinatorDelegate {
    func handleDidTapRecipe(_ recipe: Recipe) {
        let viewModel = RecipeDetailViewModelDefault(recipe: recipe,
                                                     coordinator: self)
        let detail = RecipeDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(detail, animated: true)
    }
}

extension RecipeCoordinator: RecipeDetailCoordinatorDelegate {
    func handleDidTapOrigin(_ recipe: Recipe) {
        let viewModel = RecipeLocationViewModelDefault(recipe: recipe)
        let mapVC = RecipeLocationViewController(viewModel: viewModel)
        if let presentationController = mapVC.sheetPresentationController {
                presentationController.detents = [.medium()]
        }
        navigationController?.present(mapVC, animated: true)
    }
}
