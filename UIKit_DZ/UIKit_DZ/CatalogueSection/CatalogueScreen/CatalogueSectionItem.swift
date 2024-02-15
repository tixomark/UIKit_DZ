//
//  CatalogueSectionItem.swift
//  UIKit_DZ
//
//  Created by Tixon Markin on 15.02.2024.
//

import UIKit

final class CatalogueSectionItem: UIView {
    // MARK: - Visual Components

    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .verdanaBold?.withSize(14)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    // MARK: - Public Properties
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 80)
    }

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        configureLayout()
    }

    // MARK: - Public Methods

    func configure(with data: (String, UIImage?)) {
        label.text = data.0
        imageView.image = data.1
    }

    // MARK: - Private Methods

    private func configureUI() {
        layer.cornerRadius = 16
        backgroundColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
        addSubviews(label, imageView)
    }
    
    private func configureLayout() {
        UIView.doNotTranslateAoturesizingMaskIntoConstrains(for: label, imageView)
        
        [label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
         label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         label.trailingAnchor.constraint(lessThanOrEqualTo: imageView.leadingAnchor, constant: 20),
         
         imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
         imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.25),
         imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ].activate()
    }
}
