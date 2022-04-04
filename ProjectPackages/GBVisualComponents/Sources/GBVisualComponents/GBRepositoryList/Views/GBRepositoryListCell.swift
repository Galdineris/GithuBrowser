//
//  GBRepositoryListCell.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit

public final class GBRepositoryListCell: UITableViewCell, GBListCellType {
    public typealias GBCellModel = GBRepositoryListCellModel
    public static let reuseIdentifier = "GBRepositoryListCell"
    weak public var delegate: GBListCellDelegate?

    private let avatarView: GBRepositoryAvatar = {
        let avatar = GBRepositoryAvatar(orientation: .vertical)
        avatar.accessibilityIdentifier = "viewAvatar"
        return avatar
    }()

    private let forksLabel: GBIconLabel = {
        let label = GBIconLabel()
        label.icon = UIImage(named: "forkIcon", in: Bundle.module, with: nil)
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
        label.numberOfLines = 3
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

    public func show(_ model: GBRepositoryListCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description

        forksLabel.text = model.forks > 0 ? "\(model.forks)" : "No Forks"
        starsLabel.text = model.stars > 0 ? "\(model.stars)" : "No Stars"

        avatarView.show(GBAvatarModel(username: model.avatarName))

        delegate?.fetchImage(for: model.avatarImagePath ?? "") { [weak self, model] image in
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
        delegate?.prepareForReuse()
        let avatarModel = GBAvatarModel(username: "")
        titleLabel.text = nil
        descriptionLabel.text = nil
        forksLabel.text = ""
        starsLabel.text = ""
        avatarView.show(avatarModel)
    }

    private func setupView() {
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        labelsStackView.addArrangedSubview(UIView())
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)

        metricsStackView.addArrangedSubview(starsLabel)
        metricsStackView.addArrangedSubview(forksLabel)
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
            metricsStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),

            avatarView.topAnchor.constraint(equalTo: contraintGuide.topAnchor),
            avatarView.rightAnchor.constraint(equalTo: contraintGuide.rightAnchor),
            avatarView.bottomAnchor.constraint(equalTo: contraintGuide.bottomAnchor),
            avatarView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),

            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
}
