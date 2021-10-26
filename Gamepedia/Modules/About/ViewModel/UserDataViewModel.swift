//
//  UserDataViewModel.swift
//  Gamepedia
//
//  Created by Dayton on 04/09/21.
//

import UIKit

class UserDataViewModel: Validation {
  var imageData: Data?
  var fullname: String?
  var email: String?
  var school: String?
  var city: String?

  var isValid: Bool {
    return imageData?.isEmpty == false
      && fullname?.isEmpty == false
      && email?.isEmpty == false
      && school?.isEmpty == false
      && city?.isEmpty == false
  }

  func validate(_ button: UIButton) {
    button.isEnabled = isValid
    button.borderWidth = 0.2
    button.tintColor = isValid ? .white : .lightText
    button.borderColor = isValid ? .white : nil
    button.titleLabel?.font = isValid ? Constants.Font.bold(18) : Constants.Font.regular(18)
    button.backgroundColor = isValid ? Constants.Color.background : Constants.Color.cell
  }

  func saveProfileData() {
    guard let image = imageData,
          let name = fullname,
          let email = email,
          let school = school,
          let city = city else { return }

    ProfileData.profileImage = image
    ProfileData.profileName = name
    ProfileData.profileEmail = email
    ProfileData.profileSchool = school
    ProfileData.profileCity = city
  }
}
