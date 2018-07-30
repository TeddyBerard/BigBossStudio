//
//  Films.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import Foundation

struct allFilms: Decodable {
    var count: Int
    var results = [film]()

}

struct film: Decodable {
    var title: String
    var episode_id: Int
    var opening_crawl: String
    var director: String
    var producer: String
    var release_date: String
    var characters: [String]
    var personnages: [personnage]?
}

struct personnage: Decodable {
    var name = ""
}
