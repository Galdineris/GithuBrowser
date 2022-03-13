//
//  GBRepositoryListCell.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import UIKit

public final class GBRepositoryListCell: UITableViewCell {
    static let reuseIdentifier = "GBRepositoryListCell"

    private let avatarView: GBRepositoryAvatar = {
        let avatar = GBRepositoryAvatar(orientation: .vertical)
        avatar.accessibilityIdentifier = "viewAvatar"
        return avatar
    }()

    private let forksLabel: GBIconLabel = {
        let label = GBIconLabel()
        label.icon = UIImage(named: "fork", in: Bundle.module, with: nil)
        label.tintColor = .systemOrange
        label.accessibilityIdentifier = "labelForks"
        return label
    }()
    private let starsLabel: GBIconLabel = {
        let label = GBIconLabel()
        label.icon = UIImage(systemName: "star.fill")
        label.tintColor = .systemOrange
        label.accessibilityIdentifier = "labelStars"
        return label
    }()
    private let metricsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 12
        return stack
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
        stack.distribution = .fillEqually
        return stack
    }()

    public func show(_ model: GBRepositoryListCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description

        forksLabel.text = "\(model.forks)"
        starsLabel.text = "\(model.stars)"

        avatarView.show(model.avatar)
    }

    public init() {
        super.init(style: .default,
                   reuseIdentifier: GBRepositoryListCell.reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)

        metricsStackView.addArrangedSubview(forksLabel)
        metricsStackView.addArrangedSubview(starsLabel)
        metricsStackView.addArrangedSubview(UIView())

        contentView.addSubview(labelsStackView)
        contentView.addSubview(metricsStackView)
        contentView.addSubview(avatarView)
    }

    private func configureConstraints() {
        let contraintGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            labelsStackView.topAnchor.constraint(equalTo: contraintGuide.topAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: contraintGuide.leftAnchor),
            labelsStackView.rightAnchor.constraint(equalTo: avatarView.leftAnchor),
            labelsStackView.bottomAnchor.constraint(equalTo: metricsStackView.topAnchor,
                                                    constant: 0),

            metricsStackView.leftAnchor.constraint(equalTo: contraintGuide.leftAnchor),
            metricsStackView.bottomAnchor.constraint(equalTo: contraintGuide.bottomAnchor),
            metricsStackView.rightAnchor.constraint(equalTo: avatarView.leftAnchor),

            avatarView.topAnchor.constraint(equalTo: contraintGuide.topAnchor),
            avatarView.rightAnchor.constraint(equalTo: contraintGuide.rightAnchor),
            avatarView.bottomAnchor.constraint(equalTo: contraintGuide.bottomAnchor),
            avatarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
    }
}
