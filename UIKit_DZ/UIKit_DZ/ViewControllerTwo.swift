// ViewControllerTwo.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Second screen
class ViewControllerTwo: UIViewController {
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        hello()
    }

    override func loadView() {
        super.loadView()
        print(#function)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(#function)
    }

    // MARK: - Public Methods

    func hello() {
        print("hi")
    }
}
