//
//  MainView.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

class MainView: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  // MARK: - Configuration

  private func configureTabBar() {
    self.tabBar.clipsToBounds = false
    self.tabBar.tintColor = .white
    self.tabBar.accessibilityIgnoresInvertColors = true
    self.tabBar.isTranslucent = false
    self.tabBar.barTintColor = Constants.Color.navigation
  }

  func addNavigationItem(title: String, icon: (default: UIImage, selected: UIImage), _ rootViewController: UIViewController) -> UINavigationController {

    let navigation = UINavigationController(rootViewController: rootViewController)
    navigation.tabBarItem.image = icon.default
    navigation.tabBarItem.selectedImage = icon.selected
    navigation.tabBarItem.title = title

    return navigation
  }
}
