// ChekBoxSwitch.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///  Вьюшка с ценами и свитчом
final class ChekBoxSwitch: UIView {
    lazy var nubmerPrice = 0
    lazy var title = UILabel()
    lazy var price = UILabel()
    lazy var isActive = UISwitch()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupChekbox() {
        title.frame = .init(x: 20, y: 0, width: 200, height: 35)
        title.sizeToFit()
        price.frame = .init(x: title.frame.maxX, y: 0, width: 75, height: 35)
        price.text = "  + \(nubmerPrice) руб"
        price.textColor = .systemGreen
        price.sizeToFit()
        isActive.frame = .init(x: 301, y: 0, width: 0, height: 0)
        addSubview(title)
        addSubview(price)
        addSubview(isActive)
    }
}
