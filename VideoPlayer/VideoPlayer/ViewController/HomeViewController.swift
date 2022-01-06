//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Zheng-Yuan Yu on 2022/1/3.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    let previewImageView = UIImageView()
    let videos = [
        Video(name: VideoResource.getName(.firstVideo),
              url: VideoResource.getUrl(.firstVideo),
              previewImage: UIImage.asset(.firstVideo)),
        Video(name: VideoResource.getName(.secondVideo),
              url: VideoResource.getUrl(.secondVideo),
              previewImage: UIImage.asset(.secondVideo))
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPreviewImageView()
    }

    // MARK: - Function
    func setupPreviewImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapPreviewImageView(_:)))
        previewImageView.addGestureRecognizer(gesture)
        previewImageView.isUserInteractionEnabled = true
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.layer.cornerRadius = 10.0
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.image = videos.first?.previewImage
        view.addSubview(previewImageView)

        NSLayoutConstraint.activate([
            previewImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            previewImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            previewImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            previewImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func tapPreviewImageView(_ sender: UIGestureRecognizer) {
        let videoVC = VideoViewController(videos: videos)
        videoVC.modalPresentationStyle = .overFullScreen
        present(videoVC, animated: true)
    }
}