//
//  Movie.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 02/08/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import Foundation
import SwiftyJSON


class Movie {
    var title: String = ""
    var episode_id: Int = 0
    var opening_crawl: String = ""
    var director: String = ""
    var producer: String = ""
    var release_date: String = ""
    var countCharacters : Int = 0
    var characters = [Characters]()
    
    func setMovie(json: JSON) {
        self.title = json["title"].string ?? ""
        self.episode_id = json["episode_id"].int ?? 0
        self.opening_crawl = json["opening_crawl"].string ?? ""
        self.director = json["director"].string ?? ""
        self.producer = json["producer"].string ?? ""
        self.release_date = json["release_date"].string ?? ""
    }
}
