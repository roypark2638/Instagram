//
//  PhotoPost.swift
//  Instagram
//
//  Created by Roy Park on 3/10/21.
//

import Foundation

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
