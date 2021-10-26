//
//  GeneralTableViewCell.swift
//  Gamepedia
//
//  Created by Dayton on 27/08/21.
//

import UIKit
import Cosmos

class GeneralTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var detailImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releasedDateLabel: UILabel!
  @IBOutlet weak var ratingView: CosmosView!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureGeneral(with data: GameResult) {
    self.detailImageView.setImageFrom(url: data.image)
    self.titleLabel.outlineText(text: data.name, font: Constants.Font.bold(25))

    if let date = data.released {
      let initialText = "Released: "
      self.releasedDateLabel.outlineText(
        text: initialText + DatesFormatter.yearOnBack.stringFromDate(date),
        font: Constants.Font.semibold(14))
    }

    if let rating = data.rating {
      self.ratingView.rating = rating
      self.ratingView.text = rating.toString()
    }
  }
}
