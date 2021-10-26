//
//  HomeTableViewCell.swift
//  Gamepedia
//
//  Created by Dayton on 25/08/21.
//

import UIKit
import Cosmos

class HomeTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var gameImageView: UIImageView!
  @IBOutlet weak var gameTitle: UILabel!
  @IBOutlet weak var releasedDate: UILabel!
  @IBOutlet weak var ratingView: CosmosView! {
    didSet {
      self.ratingView.settings.textFont = Constants.Font.light(13)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureCell(_ data: GameResult) {
    self.gameTitle.text = data.name
    self.gameImageView.setImageFrom(url: data.image)

    if let rating = data.rating {
      self.ratingView.rating = rating
      self.ratingView.text = rating.toString()
    }

    if let date = data.released {
      self.releasedDate.text = DatesFormatter.yearOnBack.stringFromDate(date)
    }
  }
}
