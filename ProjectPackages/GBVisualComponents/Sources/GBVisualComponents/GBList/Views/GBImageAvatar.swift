//
//  GBRepositoryAvatar.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import UIKit

public final class GBImageAvatar: UIView {
    private let orientation: Orientation
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .systemTeal
        imageView.accessibilityIdentifier = "imageViewAvatar"
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemTeal
        label.accessibilityIdentifier = "labelTitle"
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = orientation == .vertical ? .vertical : .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.accessibilityIdentifier = "stackViewContent"
        return stack
    }()


    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    public init(orientation: Orientation = .vertical) {
        self.orientation = orientation
        super.init(frame: .zero)
        setupView()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = 25
    }

    public func show(_ model: GBAvatarModel) {
        titleLabel.text = model.username

        imageView.isHidden = model.image == nil
        imageView.image = model.image
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        contentStackView.addArrangedSubview(UIView())
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(UIView())

        addSubview(contentStackView)
    }

    private func configureConstraints() {
        let imageViewSizeConstraint = imageView.widthAnchor
            .constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor),
            contentStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.leftAnchor.constraint(equalTo: self.leftAnchor),

            imageViewSizeConstraint,
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}

extension GBImageAvatar {
    public enum Orientation {
        case vertical, horizontal
    }
}
