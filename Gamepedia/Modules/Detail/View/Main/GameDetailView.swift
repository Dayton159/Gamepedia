//
//  GameDetailView.swift
//  Gamepedia
//
//  Created by Dayton on 26/08/21.
//

import UIKit

class GameDetailView: BaseView {
  // MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
  var viewModel: GameDetailViewModel!

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = Constants.Color.background
    self.bindViewModel()
    self.setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.configureRightBarButtonItem(with: Constants.Image.bookmark, type: .toogle)
    Delay.wait {
      self.configureNavBar()
    }
  }

  // MARK: - Helpers
  private func setupTableView() {
    self.tableView.registerReusableCell(GeneralTableViewCell.self)
    self.tableView.registerReusableCell(DetailTableViewCell.self)
    self.tableView.tableFooterView = UIView()
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension
    self.tableView.backgroundColor = Constants.Color.background
    self.tableView.separatorStyle = .none
    self.tableView.contentInsetAdjustmentBehavior = .never
    self.tableView.delegate = self
    self.tableView.dataSource = self
  }

  // MARK: - Bindings
  private func bindViewModel() {
    self.viewModel.state
      .asObserver()
      .subscribe(onNext: { [weak self] state in
        guard let self = self else { return }
        switch state {
        case .loading :
          Delay.wait { self.showLoader() }
        default :
          Delay.wait { self.hideLoader() }
        }
      }).disposed(by: disposeBag)

    self.viewModel.error
      .asObserver()
      .subscribe(onNext: { [weak self] error in
        guard let self = self else { return }
        Delay.wait(delay: 1.0) {
          self.showError(error.getErrorMessage, delegate: self)
        }
      }).disposed(by: disposeBag)

    self.viewModel.gameDetail
      .asObservable()
      .subscribe(onNext: { [weak self] request in
        guard let self = self, request != nil else { return }
        Delay.execute {
          self.enableBarBtn()
          self.viewModel.isMarkedFavorite()
          self.tableView.reloadData()
        }
      }).disposed(by: disposeBag)

    self.viewModel.isFavorite
      .asObservable()
      .subscribe(onNext: { [weak self] favorite in
        guard let self = self else { return }
        Delay.execute {
          self.changeFavBtnState(isFav: favorite)
        }
      }).disposed(by: disposeBag)

    self.favoriteBarBtn
      .asObservable()
      .subscribe(onNext: { [weak self] isFavorite in
        guard let self = self else { return }
        isFavorite ? self.viewModel.saveGameToFavorite() : self.viewModel.deleteGameFromFavorite()
      }).disposed(by: disposeBag)

    self.requestGameDetail()
  }

  private func requestGameDetail() {
    switch self.viewModel.request {
    case .network:
      self.viewModel.getGameDetail()
    case .local:
      self.viewModel.getDetailFromCoreData()
    case .none:
      self.viewModel.getGameDetail()
    }
  }
}

// MARK: - Extensions
extension GameDetailView: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   return 1
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell: GeneralTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      self.viewModel.configureGeneralCell(cell, indexPath)
      return cell
    default:
      let cell: DetailTableViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
      self.viewModel.configureDetailCell(cell, indexPath)
      return cell
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 0:
        return 300
    default:
        return UITableView.automaticDimension
    }
  }
}

extension GameDetailView: AlertPopUpPresentable, AlertDelegate {
  func didTapOkButton() {
    self.navigationController?.popViewController(animated: true)
  }
}
