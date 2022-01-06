//
//  ControlPanel.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/6.
//

import Foundation
import UIKit
import AVFoundation

class ControlPanelView: UIView {

    private var player: AVQueuePlayer?
    private var videos: [Video]?
    private var playerQueue: [AVPlayerItem] = []

    private let playPauseButton = PlayPauseButton()
    private let fastForwardButton = ChangeTimeButton(fastForward: true)
    private let rewindButton = ChangeTimeButton(fastForward: false)
    private let nextTrackButton = TrackButton()
    private var videoNameLabel = VideoNameLabel(text: "")
    private let closeButton = CloseButton()
    var closeView: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, player: AVQueuePlayer?, videoQueue: [Video]?) {
        self.init(frame: frame)
        self.player = player
        self.videos = videoQueue
        setupControls()
        backgroundColor = .black.withAlphaComponent(0.5)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupControls() {
        addControls()
        setupControl()
        setupPlayer()
        setupPlayerQueue()
        setupClose()
    }

    private func convertVideosToPlayerQueue(videoUrls: [String]) -> [AVPlayerItem] {
        var playerQueue: [AVPlayerItem] = []
        videoUrls.forEach {
            guard let url = URL(string: $0) else { return }
            let item = AVPlayerItem(url: url)
            playerQueue.append(item)
        }
        return playerQueue
    }

    private func addControls() {
        addSubview(playPauseButton)
        addSubview(fastForwardButton)
        addSubview(rewindButton)
        addSubview(nextTrackButton)
        addSubview(videoNameLabel)
        addSubview(closeButton)
    }

    private func setupControl() {
        videoNameLabel = VideoNameLabel(text: videos?.first?.name ?? "")
        playPauseButton.setup()
        fastForwardButton.setup()
        rewindButton.setup()
        nextTrackButton.setup()
        closeButton.setup()
        videoNameLabel.layoutPosition()
    }

    private func setupPlayer() {
        playPauseButton.player = player
        fastForwardButton.player = player
        rewindButton.player = player
        nextTrackButton.player = player
    }

    private func setupPlayerQueue() {
        guard let videos = videos else {
            return
        }

        let videoUrls: [String] = {
            var videoUrls: [String] = []
            videos.forEach {
                videoUrls.append($0.url)
            }
            return videoUrls
        }()

        playerQueue = convertVideosToPlayerQueue(videoUrls: videoUrls)
        player = AVQueuePlayer(items: playerQueue)
    }

    private func setupClose() {
        closeButton.closeView = { [weak self] in
            self?.closeView?()
        }
    }
}
