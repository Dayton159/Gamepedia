//
//  MainViewCoordinator.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift

class MainViewCoordinator: ReactiveCoordinator<Void> {

  let rootViewController: MainView!

  init(rootViewController: MainView) {
    self.rootViewController = rootViewController
  }

  override func start() -> Observable<Void> {
    coordinators.forEach { [weak self] in
      self?.coordinate(to: $0)
    }

    self.configureTabBar()
    return Observable.never()
  }

  private var coordinators: [ReactiveCoordinator<Void>] {
    [
      homeCoordinator,
      favoriteCoordinator,
      aboutCoordinator
    ]
  }

  private func configureTabBar() {
    rootViewController.viewControllers = [
      home,
      favorite,
      about
    ]
  }

  // MARK: - View Controllers

  private lazy var home: UINavigationController = {
    guard let homeIcon = Constants.Image.home,
          let homeSelected = Constants.Image.homeFill
    else { fatalError("Home Icons Not Found") }

    return rootViewController.addNavigationItem(
      title: "Home",
      icon: (homeIcon, homeSelected),
      HomeView()
    )
  }()

  private lazy var favorite: UINavigationController = {
    guard let favIcon = Constants.Image.favorite,
          let favSelected = Constants.Image.favoriteFill
    else { fatalError("Home Icons Not Found") }

    return rootViewController.addNavigationItem(
      title: "Favorite",
      icon: (favIcon, favSelected),
      FavoriteView()
    )
  }()

  private lazy var about: UINavigationController = {
    guard let aboutIcon = Constants.Image.about,
          let aboutSelected = Constants.Image.aboutFill
    else { fatalError("About Icons Not Found") }

    return rootViewController.addNavigationItem(
      title: "About",
      icon: (aboutIcon, aboutSelected),
      AboutView()
    )
  }()

  // MARK: - Coordinators

  private var homeCoordinator: HomeCoordinator {
    HomeCoordinator(rootViewController: home.viewControllers[0])
  }

  private var aboutCoordinator: AboutCoordinator {
    AboutCoordinator(rootViewController: about.viewControllers[0])
  }

  private var favoriteCoordinator: FavoriteCoordinator {
    FavoriteCoordinator(rootViewController: favorite.viewControllers[0])
  }
}
