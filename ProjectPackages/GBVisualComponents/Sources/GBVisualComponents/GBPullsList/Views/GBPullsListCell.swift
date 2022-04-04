//
//  File.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import UIKit

public final class GBPullsListCell: UITableViewCell, GBListCellType {
    public typealias GBCellModel = GBPullsListCellModel
    public static let reuseIdentifier = "GBPullsListCell"
    weak public var delegate: GBListCellDelegate?

    private let avatarView: GBImageAvatar = {
        let avatar = GBImageAvatar(orientation: .vertical)
        avatar.accessibilityIdentifier = "viewAvatar"
        return avatar
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "labelTitle"
        label.font = UIFont.preferredFont(forTextStyle: .title3,
                                          compatibleWith: .init(legibilityWeight: .bold))
        label.textColor = .systemTeal
        label.numberOfLines = 2
        return label
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = "labelDescription"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .systemGray
        label.numberOfLines = 5
        return label
    }()
    private let labelsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()

    public func show(_ model: GBPullsListCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description

        avatarView.show(GBAvatarModel(username: model.avatarName))

        delegate?.fetchImage(for: model.avatarImagePath ?? "") { [weak self, model] image in
            DispatchQueue.main.async {
                self?.avatarView.show(GBAvatarModel(username: model.avatarName,
                                                    image: image))
            }
        }
    }

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupView()
    }

    public init() {
        super.init(style: .default,
                   reuseIdentifier: Self.reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    public override func prepareForReuse() {
        super.prepareForReuse()
        delegate?.prepareForReuse()

        avatarView.show(GBAvatarModel(username: ""))
        titleLabel.text = nil
        descriptionLabel.text = nil
    }

    private func setupView() {
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)

        contentView.addSubview(labelsStackView)
        contentView.addSubview(avatarView)
    }

    private func configureConstraints() {
        let contraintGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contraintGuide.topAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: contraintGuide.leftAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: contraintGuide.bottomAnchor),
            labelsStackView.rightAnchor.constraint(equalTo: avatarView.leftAnchor),

            avatarView.centerYAnchor.constraint(equalTo: contraintGuide.centerYAnchor),
            avatarView.rightAnchor.constraint(equalTo: contraintGuide.rightAnchor),
            avatarView.widthAnchor.constraint(equalTo: contraintGuide.widthAnchor,
                                              multiplier: 0.2),

            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
}
