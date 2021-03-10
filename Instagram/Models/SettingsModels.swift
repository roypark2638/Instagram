//
//  SettingsCellModel.swift
//  Instagram
//
//  Created by Roy Park on 3/10/21.
//

import Foundation

struct Section {
    let title: String
    let option: [Option]
}

struct Option {
    let title: String
    let handler: (() -> Void)
}
