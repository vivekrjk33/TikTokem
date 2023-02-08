//
//  Model.swift
//  TikTok
//
//  Created by Vivek on 03/02/23.
//

import Foundation


struct VideoJson: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let name: String
    let videos: [Video]
}

// MARK: - Video
struct Video: Codable {
    let description: String
    let sources: String
    let subtitle: Subtitle
    let thumb: String
    let title: String
}

enum Subtitle: String, Codable {
    case byBlenderFoundation = "By Blender Foundation"
    case byGarage419 = "By Garage419"
    case byGoogle = "By Google"
}
