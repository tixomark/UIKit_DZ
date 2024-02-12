// PayerViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol PlayerViewControllerDataSource: AnyObject {
    func trackAfter(_ track: Track) -> Track
    func trackBefore(_ track: Track) -> Track
}

final class PlayerViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var bottomView: UIView!
    @IBOutlet private var albumCoverImageView: UIImageView!
    @IBOutlet private var songNameLabel: UILabel!
    @IBOutlet private var bandNameLabel: UILabel!
    @IBOutlet private var trackProgresionSlider: UISlider!
    @IBOutlet private var remainingDurationTitle: UILabel!

    // MARK: - Public Properties

    /// Трее играющий в данные момент
    var currentTrack: Track?

    /// Обьект передеющий треки в данные контроллер
    weak var dataSource: PlayerViewControllerDataSource?

    // MARK: - Private Properties

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpViewsFor(currentTrack)
    }

    // MARK: - Public Methods

    // MARK: - IBActions

    @IBAction private func previousTrackButtonTapped(_ sender: UIButton) {
        guard let currentTrack else { return }
        self.currentTrack = dataSource?.trackBefore(currentTrack)
        setUpViewsFor(self.currentTrack)
    }

    @IBAction private func nextTrackButtonTapped(_ sender: UIButton) {
        guard let currentTrack else { return }
        self.currentTrack = dataSource?.trackAfter(currentTrack)
        setUpViewsFor(self.currentTrack)
    }

    @IBAction private func playPauseButtonTapped(_ sender: UIButton) {}

    // MARK: - Private Methods

    private func setUpUI() {
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.isUserInteractionEnabled = true
        albumCoverImageView.layer.cornerRadius = 75 / 2
        albumCoverImageView.layer.borderWidth = 1
        albumCoverImageView.layer.borderColor = UIColor.white.cgColor
    }

    /// Настраивает визуальные представления в соотвествии с параметрами трека
    private func setUpViewsFor(_ track: Track?) {
        guard let track else { return }
        albumCoverImageView.image = UIImage(named: track.albumCoverImage)
        songNameLabel.text = track.name
        bandNameLabel.text = track.artist
        remainingDurationTitle.text = "-" + track.duration
        trackProgresionSlider.setValue(0, animated: false)
    }
}
