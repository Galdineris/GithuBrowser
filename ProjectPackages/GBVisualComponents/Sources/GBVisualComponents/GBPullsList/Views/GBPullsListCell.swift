//
//  File.swift
//  
//
//  Created by Rafael Galdino on 21/03/22.
//

import Foundation
import UIKit

public final class GBPullsListCell: UITableViewCell {
    static let reuseIdentifier = "GBPullsListCell"

    let imageService: GBCellImageService = GBCellImageService()

    private let avatarView: GBRepositoryAvatar = {
        let avatar = GBRepositoryAvatar(orientation: .vertical)
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

        imageService.fetchImage(for: model.avatarImagePath ?? "") { [weak self, model] image in
            DispatchQueue.main.async {
                self?.avatarView.show(GBAvatarModel(username: model.avatarName, image: image))
            }
        }
    }

    public func updateAvatar(with model: GBAvatarModel) {
        avatarView.show(model)
        setNeedsLayout()
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
        let avatarModel = GBAvatarModel(username: "",
                                        image: nil)
        titleLabel.text = nil
        descriptionLabel.text = nil
        imageService.dataTask = nil
        avatarView.show(avatarModel)
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

            avatarView.rightAnchor.constraint(equalTo: contraintGuide.rightAnchor),
            avatarView.bottomAnchor.constraint(equalTo: contraintGuide.bottomAnchor),
            avatarView.rightAnchor.constraint(equalTo: contraintGuide.rightAnchor),
            avatarView.widthAnchor.constraint(equalTo: contraintGuide.widthAnchor,
                                              multiplier: 0.2)
        ])
    }
}
