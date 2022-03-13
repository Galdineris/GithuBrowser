//
//  GBRepositoryAvatar.swift
//  
//
//  Created by Rafael Galdino on 12/03/22.
//

import UIKit

public final class GBRepositoryAvatar: UIView {
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
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        label.accessibilityIdentifier = "labelSubtitle"
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    private lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = orientation == .vertical ? .vertical : .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 12
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
        imageView.layer.cornerRadius = contentStackView.frame.width / 4
    }

    public func show(_ model: GBAvatarModel) {
        titleLabel.text = model.username

        subtitleLabel.isHidden = model.realName == nil
        subtitleLabel.text = model.realName

        imageView.isHidden = model.image == nil
        imageView.image = model.image
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)

        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(labelsStackView)
        contentStackView.addArrangedSubview(UIView())

        addSubview(contentStackView)
    }

    private func configureConstraints() {
        let imageViewSizeConstraint =
        orientation == .vertical
        ? imageView.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.5)
        : imageView.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.5)

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

extension GBRepositoryAvatar {
    public enum Orientation {
        case vertical, horizontal
    }
}
