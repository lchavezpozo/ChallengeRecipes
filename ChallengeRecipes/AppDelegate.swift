//
//  AppDelegate.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let action = RecipesDI.makeGetRecipesAction()
        let coordinator = RecipeCoordinator(window: window, getRecipesAction: action)
        coordinator.start()
        return true
    }
}

