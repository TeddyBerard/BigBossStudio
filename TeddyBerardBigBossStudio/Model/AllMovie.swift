//
//  Films.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 30/07/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class AllMovie {
    var count: Int = 0
    var results = [Movie]()
    
    func setMovies(json: JSON) {
        self.count = json["count"].int ?? 0
        for count in 0..<self.count {
            self.setMovie(json: json["results"], count: count)
        }
    }
    
    func setMovie(json: JSON, count: Int) {
        let myMovie : Movie = Movie()
        myMovie.title = json[count]["title"].string ?? ""
        myMovie.episode_id = json[count]["episode_id"].int ?? 0
        myMovie.opening_crawl = json[count]["opening_crawl"].string ?? ""
        myMovie.director = json[count]["director"].string ?? ""
        myMovie.producer = json[count]["producer"].string ?? ""
        myMovie.release_date = json[count]["release_date"].string ?? ""
        myMovie.countCharacters = json[count]["characters"].count
        for character in json[count]["characters"] {
            let myCharacters = Characters()
            myCharacters.setUrl(url: character.1.stringValue as String, name: "")
            myMovie.characters.append(myCharacters)
        }
        self.getCharacters(movie: myMovie)
    }
    
    func getCharacters(movie: Movie) {
        var i = 0
        print("HOW")
        for character in movie.characters {
            Alamofire.request("\(character.url)").responseJSON { response in
                let json = JSON(response.data!)
                let myCharacter = Characters()
                myCharacter.name = json["name"].string ?? ""
                if i == movie.countCharacters - 1 {
                    self.results.append(movie)
                    let name = Notification.Name(rawValue: "movieDonwload")
                    let notification = Notification(name: name)
                    NotificationCenter.default.post(notification)
                }
                i += 1
                movie.characters.append(myCharacter)
            }
        }
    }
}
