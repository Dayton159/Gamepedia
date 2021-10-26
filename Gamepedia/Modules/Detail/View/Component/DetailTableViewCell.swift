//
//  DetailTableViewCell.swift
//  Gamepedia
//
//  Created by Dayton on 27/08/21.
//

import UIKit

class DetailTableViewCell: UITableViewCell, Reusable {
  @IBOutlet weak var genreStackView: UIStackView!
  @IBOutlet weak var descriptionValueLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func configureDetail(with detail: GameDetailModel) {
    self.descriptionValueLabel.text = detail.description?.removeHTMLTags()
    self.getGenreText(stackView: genreStackView, genres: detail.genres)
  }

  // MARK: - Helpers
  private func getGenreText(stackView: UIStackView, genres: [Genre]?) {
    stackView.refresh()
    guard let genres = genres?.prefix(3) else { return }
    genres.forEach { [unowned self] genre in
      let subview = self.createLabel(from: genre.name)
      stackView.addArrangedSubview(subview)
    }
  }

  private func createLabel(from text: String?) -> UILabel {
    let label = UILabel()
    label.font = Constants.Font.regular(14)
    label.backgroundColor = Constants.Color.cell
    label.layer.masksToBounds = true
    label.cornerRadius = 10
    label.text = text
    label.textAlignment = .center
    label.textColor = .white
    return label
  }
}
