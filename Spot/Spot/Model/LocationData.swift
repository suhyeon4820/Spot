//
//  Data.swift
//  Spot
//
//  Created by suhyeon on 2021/02/07.
//

import Foundation

struct LocationData: Codable {
    let Result: [Districts]
}

struct Districts: Codable {
    let sidoName: String
    let sidoNumb: Int
    let sigunguName: [String]
    let sigunguNumb: [String]
}
