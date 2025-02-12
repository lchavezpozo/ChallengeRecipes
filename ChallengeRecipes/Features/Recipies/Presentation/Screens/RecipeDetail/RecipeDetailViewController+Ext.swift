//
//  RecipeDetailViewController+Ext.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 12/02/25.
//
import UIKit

extension RecipeDetailViewController {
    enum Constants {
        enum Layout {
            static let padding: CGFloat = 20
            static let spacingBetweenLabels: CGFloat = 12
        }

        enum Colors {
            static let overlayBackgroundColor = UIColor.black.withAlphaComponent(0.5)
            static let descriptionTextColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
            static let ingredientsTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
            static let preparationTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        }

        enum Fonts {
            static let titleLabelFont = UIFont(name: "AvenirNext-Bold", size: 34)
            static let descriptionLabelFont = UIFont(name: "AvenirNext-Italic", size: 18)
            static let ingredientsTitleFont = UIFont(name: "AvenirNext-Bold", size: 22)
            static let preparationTitleFont = UIFont(name: "AvenirNext-Bold", size: 22)
            static let ingredientsInfoFont = UIFont(name: "AvenirNext-Regular", size: 18)
            static let preparationInfoFont = UIFont(name: "AvenirNext-Regular", size: 18)
            static let mapButtonFont = UIFont(name: "AvenirNext-Bold", size: 20)
        }

        enum Texts {
            static let ingredientsTitle = "🍴 Ingredientes"
            static let preparationTitle = "👩‍🍳 Preparación"
            static let mapButtonTitle = "📍Ver Origen en el Mapa"
        }

        enum UI {
            static let shadowOpacity: Float = 0.2
            static let shadowRadius: CGFloat = 10
            static let shadowOffset = CGSize(width: 0, height: 5)
            static let cornerRadius: CGFloat = 20
            static let borderWidth: CGFloat = 1
            static let lightGrayAlpha: CGFloat = 0.3
        }
    }

}
