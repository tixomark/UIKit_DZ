// PlaylistViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Констроллер содержащий список треков пользователя
final class PlaylistViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet private var albumCoverImageViews: [UIImageView]!
    @IBOutlet private var trackNameLabels: [UILabel]!
    @IBOutlet private var bandNameLabels: [UILabel]!
    @IBOutlet private var trackDurationLabels: [UILabel]!

    // MARK: - Private Properties

    /// Массив содержаций все треки данного экрана
    private var tracks = [
        Track(
            albumCoverImage: "valleyOfTheDammedCover",
            name: "Valley Of The Damned",
            artist: "Dragonforce",
            duration: "7:12"
        ),
        Track(
            albumCoverImage: "standaloneComplexCover",
            name: "Lithium Flower",
            artist: "Scott Matthew",
            duration: "3:25"
        ),
        Track(
            albumCoverImage: "longRoadOutOfEdenCover",
            name: "Long Road Out Of Eden",
            artist: "Eagles",
            duration: "10:17"
        ),
        Track(
            albumCoverImage: "novocaineForTheSoulCover",
            name: "Novocaine For The Soul",
            artist: "eels",
            duration: "3:07"
        ),
        Track(albumCoverImage: "MLPCover", name: "The Magic of Friendship Grows", artist: "Mane Six", duration: "3:16"),
        Track(albumCoverImage: "berserkerCover", name: "Ghost In the Rain", artist: "Beast In Black", duration: "5:35")
    ]

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Private Methods

    private func setUpUI() {
        for view in albumCoverImageViews {
            view.image = UIImage(named: tracks[view.tag].albumCoverImage)
            view.layer.cornerRadius = 12
        }
        for label in trackNameLabels {
            label.text = tracks[label.tag].name
        }
        for label in bandNameLabels {
            label.text = tracks[label.tag].artist
        }
        for label in trackDurationLabels {
            label.text = tracks[label.tag].duration
        }
    }

    // MARK: - IBActions

    @IBAction func didSelectTrack(_ sender: UIButton) {}
}
