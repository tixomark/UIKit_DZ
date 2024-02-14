// SubmissionButton.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Кнопка подтверждения
final class SubmissionButton: UIButton {
    override init(frame: CGRect) {
        var customFrame = frame
        customFrame.size.height = 44
        super.init(frame: customFrame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
