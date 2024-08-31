//_________SKAIK_MO_________
//
//  ItemCollectionViewCell.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 29/08/2023.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var superStack: UIStackView!
    @IBOutlet weak var itemsStack: GradientView!
    @IBOutlet weak var ratingStack: rStack!
    @IBOutlet weak var itemsHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultStack: UIStackView!
    @IBOutlet weak var periodLabel: UILabel!

    private var minItemsHeight: CGFloat = .zero // When the rating is equal to zero
    private var maxItemsHeight: CGFloat = .zero // When the rating is equal to 10
    private var remainingItemsHeight: CGFloat = .zero // Remaining height of itemsStack
    private var ItemsHeight: CGFloat = .zero
    var object: Game?
    var isDateHidden = false {
        didSet {
            self.setDate()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
//        self.isDateHidden = true
        self.setCorner()
        self.rotate()
        self.itemsHeightConstraint.constant = .zero
        guard let object else { return }
        self.dateLabel.text = object.date._stringDate
        self.ratingLabel.text = "\(object.rating)"
        self.calaulateHeight(object.rating)
        self.setRating(object.id)
    }

}

extension ItemCollectionViewCell {

    private func setDate() {
        switch self.isDateHidden {
        case true:
            self.lineView.alpha = 0
            self.dateLabel.alpha = 0
        case false:
            self.lineView.alpha = 1
            self.dateLabel.alpha = 1
        }
    }

    private func setCorner() {
        self.itemsStack.cornerRadius = self.itemsStack.frame.width / 2
        let maskedCorners = self.itemsStack._roundCorners(isTopLeft: true, isTopRight: true)
        self.itemsStack.layer.maskedCorners = maskedCorners
    }

    private func rotate() {
        let angle = -(90 * CGFloat(Double.pi) / 180)
        self.team1Image.transform = CGAffineTransform(rotationAngle: angle)
        self.resultLabel.transform = CGAffineTransform(rotationAngle: angle)
        self.team2Image.transform = CGAffineTransform(rotationAngle: angle)
    }

    private func calaulateHeight(_ rating: CGFloat) {
        let resultStackHeight = team1Image.frame.height + team2Image.frame.height + resultLabel.frame.height + resultStack.allSpacing
        self.minItemsHeight = resultStackHeight + ratingStack.frame.height + self.itemsStack.allSpacing + itemsStack.directionalLayoutMargins.top + itemsStack.directionalLayoutMargins.bottom
        self.maxItemsHeight = self.frame.height - dateLabel.frame.height - dateStackView.allSpacing - periodLabel.frame.height - superStack.allSpacing
        self.remainingItemsHeight = maxItemsHeight - minItemsHeight
        self.ItemsHeight = minItemsHeight + (remainingItemsHeight * rating / 10)
    }

    private func setRating(_ gameID: String) {
        if let _topVC = self._topVC as? CardViewController, !_topVC.showObjects.contains(gameID) {
            _topVC.showObjects.append(gameID)
            self.hideContant()
            self.showContant()
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2) {
                    self.setHeightItemsStack()
                }
            }
        } else {
            self.setHeightItemsStack()
        }
    }

    private func hideContant() {
        self.ratingStack.isHidden = true
        self.resultStack.isHidden = true
    }

    private func showContant() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            UIView.animate(withDuration: 1) {
                self.ratingStack.isHidden = false
                self.resultStack.isHidden = false
                self.contentView.layoutIfNeeded()
            }
        }
    }

    private func setHeightItemsStack() {
        self.itemsHeightConstraint.constant = ItemsHeight
        self.contentView.layoutIfNeeded()
        self.applyGradient()
    }

    private func applyGradient() {
        self.itemsStack.startColor = getColor()
        self.itemsStack.endColor = .white.withAlphaComponent(0.0)
        self.itemsStack.startPoint = GradientOrientation.vertical.startPoint
        self.itemsStack.endPoint = GradientOrientation.vertical.endPoint
    }

    private func getColor() -> UIColor {
        guard let rating = object?.rating else { return "BD3131"._hexColor }
        switch rating {
        case 7...10:
            return "31BD60"._hexColor
        case 4..<7:
            return "FFB700"._hexColor
        default:
            return "BD3131"._hexColor

        }
    }

}

extension UIStackView {
    var allSpacing: CGFloat {
        guard self.subviews.count > 1 else { return 0.0 }
        return self.spacing * CGFloat(self.subviews.count - 1)
    }
}
