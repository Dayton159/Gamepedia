//
//  FavoriteView.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import UIKit
import SkeletonView

class FavoriteView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var viewModel: FavoriteViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Color.background
    self.bindViewModel()
    self.setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.configureNavBar(withTitle: "Favorite", prefersLargeTitles: true)
    self.viewModel.getFavoriteGames()
  }

  // MARK: - Helpers
  private func setupTableView() {
    self.tableView.registerReusableCell(HomeTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = Constants.Color.background
    self.tableView.separatorStyle = .none
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  private func bindViewModel() {
    self.viewModel.state
      .asObserver()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading :
          Delay.execute {
            self.showLoader()
          }
        default :
          Delay.execute {
            self.hideLoader()
          }
        }
      }).disposed(by: disposeBag)

    self.viewModel.error
      .asObserver()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        Delay.wait {
          self.showError(error.getErrorMessage)
        }
      }).disposed(by: disposeBag)

    self.viewModel.gameList
      .asObservable()
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        Delay.execute {
          self.tableView.reloadData()
        }
      }).disposed(by: disposeBag)
  }
}

extension FavoriteView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.viewModel.getNumberOfGame == 0 {
      tableView.setEmptyView(
        title: "Favorite Not Found",
        detail: "Oops! Seems like there is nothing to be found. Add some games to your favorite list first",
        titleBtn: "Refresh", delegate: self)
    } else {
      tableView.backgroundView = nil
    }
    return self.viewModel.getNumberOfGame
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: HomeTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
    self.viewModel.configureCell(cell, indexPath)
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedGame = self.viewModel.getGameAt(indexPath)
    self.viewModel.didSelectGame.onNext(selectedGame)
  }
}

extension FavoriteView: EmptyViewDelegate, AlertPopUpPresentable {
  func didTapButtonAction() {
    self.viewModel.getFavoriteGames()
  }
}
