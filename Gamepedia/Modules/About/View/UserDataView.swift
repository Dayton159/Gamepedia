//
//  UserDataView.swift
//  Gamepedia
//
//  Created by Dayton on 03/09/21.
//

import UIKit

class UserDataView: BaseView {
  @IBOutlet weak var imageBtn: UIButton!
  @IBOutlet weak var nameContainer: InputContainerView!
  @IBOutlet weak var emailContainer: InputContainerView!
  @IBOutlet weak var schoolContainer: InputContainerView!
  @IBOutlet weak var cityContainer: InputContainerView!
  @IBOutlet weak var updateBtn: UIButton!

  var viewModel: UserDataViewModel!
  private let emailValidator = EmailValidator()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.bindViewModel()
  }

  private func bindViewModel() {
    self.nameContainer.textFieldObservable
      .subscribe(onNext: { [unowned self] name in
        self.viewModel.fullname = !name.isEmpty ? name : nil
        self.viewModel.validate(updateBtn)
      }).disposed(by: disposeBag)

    self.emailContainer.textFieldObservable
      .subscribe(onNext: { [unowned self] email in
        self.viewModel.email = self.emailValidator.validate(email) ? email : nil
        self.viewModel.validate(updateBtn)
      }).disposed(by: disposeBag)

    self.schoolContainer.textFieldObservable
      .subscribe(onNext: { [unowned self] school in
        self.viewModel.school = !school.isEmpty ? school : nil
        self.viewModel.validate(updateBtn)
      }).disposed(by: disposeBag)

    self.cityContainer.textFieldObservable
      .subscribe(onNext: { [unowned self] city in
        self.viewModel.city = !city.isEmpty ? city : nil
        self.viewModel.validate(updateBtn)
      }).disposed(by: disposeBag)

    self.imageBtn.rx
      .tap.bind(onNext: { [unowned self] in
        self.handleSelectPhoto()
      }).disposed(by: disposeBag)

    self.updateBtn.rx
      .tap.bind(onNext: { [unowned self] in
        self.viewModel.saveProfileData()
        self.navigationController?.popViewController(animated: true)
      }).disposed(by: disposeBag)

    self.viewModel.validate(updateBtn)
  }

  override func viewWillAppear(_ animated: Bool) {
    self.configureNavBar(prefersLargeTitles: false)
  }

  private func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.sourceType = .photoLibrary
    imagePickerController.allowsEditing = true
    imagePickerController.delegate = self
    present(imagePickerController, animated: true, completion: nil)
  }
}

// MARK: - Extensions

extension UserDataView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let image = info[.editedImage] as? UIImage
    self.viewModel.imageData = image?.pngData()
    Delay.execute {
      self.viewModel.validate(self.updateBtn)
      self.imageBtn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
      self.imageBtn.borderColor = .white
      self.imageBtn.borderWidth = 2.0
      self.imageBtn.cornerRadius = 80
      self.imageBtn.imageView?.cornerRadius = 80
      self.dismiss(animated: true, completion: nil)
    }
  }
}
