//
//  RecipesListSection.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 10/02/25.
//
import UIKit

enum RecipesListSection: Int {
    case main

    func getSectionLayout() -> NSCollectionLayoutSection {
        switch self {
        case .main:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(150))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.interItemSpacing = .fixed(10)
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.interGroupSpacing = 10
            return section
        }
    }
}

struct RecipesItem: Hashable {
    let id = UUID()
    let viewModel: RecipeCellViewModel

    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    static func == (lhs: RecipesItem, rhs: RecipesItem) -> Bool {
        return lhs.id == rhs.id
    }
}
