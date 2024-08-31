//_________SKAIK_MO_________
//
//  CardViewController.swift
//  CardAnimation
//
//  Created by Mohammed Skaik on 05/09/2023.
//

import UIKit

class CardViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var topImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var bagStack: rStack!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var t_shartStack: rStack!
    @IBOutlet weak var profileBlueView: rView!

    // MARK: Properties
    var showObjects: [String] = []
    private var objects: [Game] = []
    private var followButton = rButton(type: .custom)
    private let height = 36.0
    private let width = 100.0
    private let duration = 0.5

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._isHideNavigation = true
    }

}

// MARK: - Actions
private extension CardViewController {

    private func swipeUpAction() {
        self.topImageConstraint.constant = -30
        UIView.animate(withDuration: duration) {
            self.imageHeight.constant = 160

            // Apply a 3D rotation transform
            var transform = CATransform3DIdentity
            transform.m34 = -1.0 / 500 // This controls the depth effect

            // Apply a rotation on the X-axis
            let angleInRadians = CGFloat(45.0 * Double.pi / 180.0)
            transform = CATransform3DRotate(transform, angleInRadians, 1.0, 0.0, 0.0)

            // Apply a 90-degree rotation on the Z-axis
            let zRotationAngleInRadians = CGFloat(-90.0 * Double.pi / 180.0)
            transform = CATransform3DRotate(transform, zRotationAngleInRadians, 0.0, 0.0, 1.0)
            self.imageView.layer.transform = transform

            self.followButton.frame = self.setFrameCustomButton(true)
            self.view.layoutIfNeeded()
        }
    }

    private func swipeDownAction() {
        self.topImageConstraint.constant = 0
        let angle: CGFloat = CGFloat(-0 * Double.pi / 180)
        UIView.animate(withDuration: duration) {
            self.imageHeight.constant = 257
            self.imageView.transform = CGAffineTransform(rotationAngle: angle)

            self.followButton.frame = self.setFrameCustomButton()
            self.view.layoutIfNeeded()
        }
    }

}
// MARK: - Configurations
private extension CardViewController {

    private func setUpView() {
        let masked = self.backgroundImage._roundCorners(isTopLeft: true, isTopRight: true)
        self.backgroundImage.layer.maskedCorners = masked
        self.backgroundImage.cornerRadius = 45
        self.scrollView.delegate = self
        self.imageWidth.constant = 179
        self.imageHeight.constant = 257
        DispatchQueue.main.async {
            self.followButton = self.createCustomButton()
            self.view.addSubview(self.followButton)
        }
        self.setCoinsBag()
        self.setCollectionView()
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        blurView.frame = t_shartStack.bounds
        blurView.alpha = 0.2
        self.t_shartStack.addSubview(blurView)
    }

    private func setUpData() {
        self.objects = [
                .init(rating: 7, date: Date()._add(days: 1, hours: 1)),
                .init(rating: 6, date: Date()._add(days: 1, hours: 1)),
                .init(rating: 3.4, date: Date()._add(days: 1, hours: 1)),
                .init(rating: 9.9, date: Date()._add(days: 2, hours: 1)),
                .init(rating: 8.8, date: Date()._add(days: 2, hours: 1)),
                .init(rating: 3, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 3.8, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 7.4, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 0, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 3.8, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 5, date: Date()._add(days: 3, hours: 1)),
                .init(rating: 3, date: Date()._add(days: 4, hours: 1)),
                .init(rating: 7, date: Date()._add(days: 4, hours: 1)),
                .init(rating: 10, date: Date()._add(days: 4, hours: 1)),
                .init(rating: 1.5, date: Date()._add(days: 4, hours: 1)),
                .init(rating: 0.5, date: Date()._add(days: 5, hours: 1)),
        ]
        self.objects.sort(by: >)
        self.collectionView.reloadData()
    }

    private func setCollectionView() {
        self.collectionView.contentInset.left = 10
        self.collectionView.contentInset.right = 10
        self.collectionView._registerCell = ItemCollectionViewCell.self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    private func setCoinsBag() {
        let image = "ic_coinsBag"._toImage
        let imageView = UIImageView(image: image)
        imageView.shadowColor = "#FFB700"._color
        imageView.shadowOffset = .init(width: 0, height: 4)
        imageView.shadowRadius = 24
        imageView.shadowOpacity = 0.5
        bagStack.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 37),
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.topAnchor.constraint(equalTo: bagStack.topAnchor, constant: -7),
            imageView.leadingAnchor.constraint(equalTo: bagStack.leadingAnchor, constant: 10),
            ])
    }

}

// MARK: - Custom Button
extension CardViewController {

    private func setFrameCustomButton(_ isSwipeUp: Bool = false) -> CGRect {
        let xPosition: Double
        let yPosition: Double
        if isSwipeUp {
            xPosition = self.imageContainer.frame.midX - (self.width / 2)
            yPosition = (self._getStatusBarHeightTop ?? 0) + self.imageView.frame.maxY - self.height
        } else {
            xPosition = self.imageContainer.frame.maxX - (self.width / 3)
            yPosition = (self._getStatusBarHeightTop ?? 0) + self.imageContainer.frame.minY + (self.imageHeight.constant / 2) - (self.height / 2)
        }
        return CGRect(x: xPosition, y: yPosition, width: self.width, height: self.height)
    }

    private func createCustomButton() -> rButton {
        let button = rButton(type: .custom)
        button.frame = self.setFrameCustomButton()
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = button.bounds
        button.addSubview(blurView)
        button.backgroundColor = "#FFB700"._color.withAlphaComponent(0.2)
        button.shadowColor = "#4C2086"._color
        button.shadowOffset = CGSize(width: 0, height: 3)
        button.shadowRadius = 6
        button.shadowOpacity = 0.15
        button.shadowBlur = 10
        button.clipsToBounds = true
        button.setTitle("follow", for: .normal)
        button.setTitleColor("#562391"._color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setImage("ic_notificationsOutline"._toImage, for: .normal)
        let image = "ic_notificationsOutline"._toImage
        let imageView = UIImageView(image: image)
        if let titleLabel = button.titleLabel {
            button.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10),
                imageView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
                ])
        }
        button.addSubview(imageView)
        return button
    }
}

extension CardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ItemCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
        cell.object = self.objects[indexPath.row]
        cell.configureCell()
        if indexPath.row == 0 {
            cell.isDateHidden = false
        } else {
            cell.isDateHidden = self.objects[indexPath.row].date.compare(previousDate: self.objects[indexPath.row - 1].date)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 55.0
        let height = collectionView.frame.height
        return .init(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}


extension CardViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == self.scrollView else { return } // because scroll in collection view
        if scrollView.scrollDirection == .down, scrollView.contentOffset.y <= 80 {
            swipeDownAction()
        } else {
            swipeUpAction()
        }
    }

}

extension UIScrollView {
    enum ScrollDirection {
        case up, down, unknown
    }

    var scrollDirection: ScrollDirection {
        guard let superview = superview else { return .unknown }
        return panGestureRecognizer.translation(in: superview).y > 0 ? .down : .up
    }
}
