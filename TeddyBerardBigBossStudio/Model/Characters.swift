//
//  Characters.swift
//  TeddyBerardBigBossStudio
//
//  Created by Teddy Bérard on 02/08/2018.
//  Copyright © 2018 TeddyBerard. All rights reserved.
//

import Foundation

class Characters {
    var url : String = ""
    var name : String = ""
    
    func setUrl(url: String, name: String) {
        if self.url == "" {
            self.url = url
        }
        self.name = name
    }
}
