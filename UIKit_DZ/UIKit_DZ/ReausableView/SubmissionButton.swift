// SubmissionButton.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class SubmissionButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        layer.cornerRadius = 12
        frame = CGRect(x: 0, y: 700, width: 335, height: 44)
        backgroundColor = #colorLiteral(red: 0.3460897207, green: 0.7455198169, blue: 0.7799417377, alpha: 1)
    }
}
