// PayerViewController.swift
// Copyright © RoadMap. All rights reserved.

import AVFoundation
import UIKit

/// Источник данных для данного экрана.
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
    @IBOutlet private var trackProgresionSlider: CustomSlider!
    @IBOutlet private var remainingDurationTitle: UILabel!
    @IBOutlet private var playPauseButton: UIButton!
    @IBOutlet private var volumeSlider: CustomSlider!

    // MARK: - Public Properties

    /// Трее играющий в данные момент
    var currentTrack: Track?

    /// Обьект передеющий треки в данные контроллер
    weak var dataSource: PlayerViewControllerDataSource?

    // MARK: - Private Properties

    /// Переменная в которой харниться текуший работающий плеер
    private var player: AVAudioPlayer!

    /// Таймер для обновления позиции бегунка слайдера и оставшегося времени до конца терка
    private lazy var timer = CADisplayLink(target: self, selector: #selector(updateTrackProgress))

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpViewsFor(currentTrack)
        startPlayer()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
        player = nil
    }

    // MARK: - IBActions

    @IBAction private func previousTrackButtonTapped(_ sender: UIButton) {
        guard let currentTrack else { return }
        self.currentTrack = dataSource?.trackBefore(currentTrack)
        setUpViewsFor(self.currentTrack)
        startPlayer()
    }

    @IBAction private func nextTrackButtonTapped(_ sender: UIButton) {
        guard let currentTrack else { return }
        self.currentTrack = dataSource?.trackAfter(currentTrack)
        setUpViewsFor(self.currentTrack)
        startPlayer()
    }

    @IBAction private func playPauseButtonTapped(_ sender: UIButton) {
        if player.isPlaying {
            player.pause()
            timer.isPaused = true
            playPauseButton.setImage(UIImage(.play), for: .normal)
        } else {
            player.play()
            timer.isPaused = false
            playPauseButton.setImage(UIImage(.pause), for: .normal)
        }
    }

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        player = nil
        timer.invalidate()
        dismiss(animated: true)
    }

    // MARK: - Private Methods

    private func setUpUI() {
        bottomView.layer.cornerRadius = 20
        bottomView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.isUserInteractionEnabled = true
        albumCoverImageView.layer.cornerRadius = 75 / 2
        albumCoverImageView.layer.borderWidth = 1
        albumCoverImageView.layer.borderColor = UIColor.white.cgColor

        trackProgresionSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        trackProgresionSlider.addTarget(self, action: #selector(userBeginDragging(_:)), for: .touchDown)
        trackProgresionSlider.isContinuous = false

        timer.add(to: .main, forMode: .common)

        volumeSlider.transform = CGAffineTransformMakeRotation(.pi / -2)
        volumeSlider.frame.origin = CGPoint(x: 10, y: 280)
        volumeSlider.setThumbImage(UIImage(.sliderThumb), for: .normal)
        volumeSlider.setThumbImage(UIImage(.sliderThumb), for: .highlighted)
    }

    /// Настраивает визуальные представления в соотвествии с параметрами трека
    private func setUpViewsFor(_ track: Track?) {
        guard let track else { return }
        albumCoverImageView.image = UIImage(named: track.albumCoverImage)
        songNameLabel.text = track.name
        bandNameLabel.text = track.artist
        remainingDurationTitle.text = "-" + track.duration
        trackProgresionSlider.setValue(0, animated: false)
        trackProgresionSlider.setThumbImage(UIImage(.sliderThumb), for: .normal)
        trackProgresionSlider.setThumbImage(UIImage(.sliderThumb), for: .highlighted)
    }

    /// Создает новый плеер и начинает проигрывание трека
    private func startPlayer() {
        guard let trackPath = Bundle.main.path(forResource: currentTrack?.name, ofType: "mp3")
        else { return }

        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: trackPath))
            player.delegate = self
            player.prepareToPlay()
            player.play()
            playPauseButton.setImage(UIImage(.pause), for: .normal)
        } catch {}
    }

    /// Обновляет положение бегунка слайдера и текст лейбла
    @objc private func updateTrackProgress() {
        let progress = Float(player.currentTime / player.duration)
        trackProgresionSlider.setValue(progress, animated: true)
        let secondsLeft = Int(player.duration - player.currentTime)
        let minuteComponent = secondsLeft / 60
        let secondComponent = String(format: "%02d", secondsLeft % 60)
        remainingDurationTitle.text = "-\(minuteComponent):" + secondComponent
    }

    @objc private func sliderValueDidChange(_ sender: UISlider) {
        player.currentTime = Double(sender.value) * player.duration
        timer.isPaused = false
    }

    @objc private func userBeginDragging(_ sender: UISlider) {
        timer.isPaused = true
    }
}

extension PlayerViewController: AVAudioPlayerDelegate {
    /// Включает следующий трек после того как текущий закончился
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        nextTrackButtonTapped(UIButton())
    }
}
