//
//  HomeView.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import RxSwift
import SkeletonView

class HomeView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var viewModel: HomeViewModel!
  private let searchController = UISearchController(searchResultsController: nil)

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Color.background
    self.bindViewModel()
    self.setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureNavBar(withTitle: "Gamepedia", prefersLargeTitles: true)
    self.configureSearchBar()
    self.setupSearchTextField()
  }

  // MARK: - Helpers
  private func setupTableView() {
    self.tableView.registerReusableCell(HomeTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = Constants.Color.background
    self.tableView.separatorStyle = .none
    self.tableView.keyboardDismissMode = .onDrag
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  private func configureSearchBar() {
    searchController.searchBar.showsCancelButton = false
    navigationItem.searchController = searchController
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.placeholder = "Search Game"
    searchController.searchBar.enablesReturnKeyAutomatically = true
    definesPresentationContext = false
  }

  private func setupSearchTextField() {
    if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
      textfield.keyboardAppearance = .dark
      textfield.textColor = .white
      textfield.backgroundColor = Constants.Color.cell
      textfield.delegate = self
    }
  }

  // MARK: - Bindings
  private func bindViewModel() {
    self.viewModel.state
      .asObserver()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading :
          Delay.wait {
            self.view.showAnimatedSkeleton(usingColor: .gray)
            self.showLoader()
          }
        default :
          Delay.wait {
            self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.5))
            self.hideLoader()
          }
        }
      }).disposed(by: disposeBag)

    self.viewModel.error
      .asObserver()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        Delay.wait(delay: 1.0) {
          self.showError(error.getErrorMessage)
        }
      }).disposed(by: disposeBag)

    self.viewModel.gameList
      .asObservable()
      .subscribe(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.tableView.reloadData()
      }).disposed(by: disposeBag)

    self.viewModel.getGameList()
  }
}

// MARK: - Extensions
extension HomeView: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if self.viewModel.getNumberOfGame == 0 {
      tableView.setEmptyView(
        title: "Game Data Not Found",
        detail: "Oops! Seems like there is nothing to be found. You do not have any game data",
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

extension HomeView: UITextFieldDelegate {

  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.text = ""
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    if let query = textField.text {
      query.isEmpty ? self.viewModel.getGameList() : self.viewModel.searchForGame(with: query)
      searchController.dismiss(animated: true, completion: nil)
    }
  }
}

extension HomeView: EmptyViewDelegate, AlertPopUpPresentable {

  func didTapButtonAction() {
    self.viewModel.getGameList()
  }
}

extension HomeView: SkeletonTableViewDataSource {

  func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }

  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return HomeTableViewCell.reuseIdentifier
  }
}
