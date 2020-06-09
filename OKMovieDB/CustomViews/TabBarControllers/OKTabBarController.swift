//
//  OKTabBarController.swift
//  OKMovieDB
//
//  Created by Önder Koşar on 31.05.2020.
//  Copyright © 2020 Önder Koşar. All rights reserved.
//

import UIKit

class OKTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGray
        viewControllers                 = [createCategoriesNC(), createSearchNC(), createFavoritesNC()]
    }
    
    
    func createCategoriesNC() -> UINavigationController {
        let categoriesVC            = CategoriesVC()
        
        categoriesVC.title          = "Categories"
        categoriesVC.tabBarItem     = UITabBarItem(title: "Categories", image: SFSymbols.eyeglasses, tag: 0)
        
        return UINavigationController(rootViewController: categoriesVC)
    }
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC             = FavoritesVC()
        
        favoritesVC.title           = "Favorites"
        favoritesVC.tabBarItem      = UITabBarItem(title: "Favorites", image: SFSymbols.star, tag: 2)
        
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC                = SearchVC()
        
        searchVC.title              = "Search"
        searchVC.tabBarItem         = UITabBarItem(title: "Search", image: SFSymbols.search, tag: 1)
        
        return UINavigationController(rootViewController: searchVC)
    }
}
