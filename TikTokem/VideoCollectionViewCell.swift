//
//  VideoCollectionViewCell.swift
//  TikTokem
//
//  Created by Vivek on 07/02/23.
//

import UIKit
import GSPlayer

class VideoCollectionViewCell: UICollectionViewCell {
    
    var videos : String!
    @IBOutlet weak var playImg: UIImageView!
    
    @IBOutlet weak var playerView: VideoPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
    func play() {
        playImg.isHidden = true
        playerView.play(for: URL(string: videos)!)
        playerView.isHidden = false
    }
    
    func pause() {
        playerView.pause(reason: .hidden)
        
    }
    
    func viewSetup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.playerView.isUserInteractionEnabled = true
        self.playerView.addGestureRecognizer(tap)
    }
    
    @objc func viewTapped() {
        if playerView.state == .playing {
            playImg.isHidden = false
            playerView.pause(reason: .userInteraction)
        }else{
            playImg.isHidden = true
            playerView.resume()
        }
    }
}


