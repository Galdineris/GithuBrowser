//
//  GBIconLabel.swift
//  
//
//  Created by Rafael Galdino on 13/03/22.
//

import Foundation
import UIKit

public final class GBIconLabel: UIView {
    public var text: String = "" {
        didSet {
            label.text = text
        }
    }
    public var icon: UIImage? = nil {
        didSet {
            iconView.image = icon
        }
    }
    public override var tintColor: UIColor! {
        didSet {
            label.textColor = tintColor
            iconView.tintColor = tintColor
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3, compatibleWith: .init(legibilityWeight: .bold))
        label.adjustsFontSizeToFitWidth = false
        label.lineBreakMode = .byTruncatingHead
        label.accessibilityIdentifier = "label"
        return label
    }()
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "viewIcon"
        return imageView
    }()

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    public init() {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        configureConstraints()
    }

    private func buildViewHierarchy() {
        addSubview(label)
        addSubview(iconView)
    }

    private func configureConstraints() {
        let labelFontSize = label.font.pointSize
        NSLayoutConstraint.activate([
            iconView.heightAnchor.constraint(equalTo: iconView.widthAnchor),
            iconView.heightAnchor.constraint(equalToConstant: labelFontSize),
            iconView.leftAnchor.constraint(equalTo: leftAnchor),

            label.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 4),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
        ])
    }
}
