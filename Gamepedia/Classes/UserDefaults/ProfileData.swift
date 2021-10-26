//
//  ProfileData.swift
//  Gamepedia
//
//  Created by Dayton on 04/09/21.
//

import Foundation

struct ProfileData {

  @Defaults(key: "profileImage", defaultValue: Constants.PngData.profileImgData())
  static var profileImage: Data

  @Defaults(key: "profileName", defaultValue: "Dayton")
  static var profileName: String

  @Defaults(key: "profileEmail", defaultValue: "dayton159@gmail.com")
  static var profileEmail: String

  @Defaults(key: "profileSchool", defaultValue: "Universitas Internasional Batam")
  static var profileSchool: String

  @Defaults(key: "profileCity", defaultValue: "Tanjungpinang")
  static var profileCity: String

}
