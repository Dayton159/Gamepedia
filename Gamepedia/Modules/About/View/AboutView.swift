//
//  AboutView.swift
//  Gamepedia
//
//  Created by Dayton on 24/08/21.
//

import UIKit

class AboutView: BaseView {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var schoolLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!

  var viewModel: AboutViewModel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.configureRightBarButtonItem(with: Constants.Image.edit, type: .defaultAction)
    self.enableBarBtn()
    self.configureNavBar(withTitle: "Profile", prefersLargeTitles: true)
    self.loadProfileData()
  }

  private func bindViewModel() {
    self.barButton
      .asObservable()
      .subscribe(onNext: { [weak self] action in
        guard let self = self else { return }
        self.viewModel.didTapEdit.onNext(action)
      }).disposed(by: disposeBag)
  }

  func loadProfileData() {
    self.imageView.image = UIImage(data: ProfileData.profileImage)
    self.nameLabel.text = ProfileData.profileName
    self.emailLabel.text = ProfileData.profileEmail
    self.schoolLabel.text = ProfileData.profileSchool
    self.cityLabel.text = ProfileData.profileCity
  }
}
