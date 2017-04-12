//
//  AnimeModel.swift
//  AniCore
//
//  Created by Kyle Brown on 10/04/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Mapper

class AnimeModel: SeriesModel {
    var totalEpisodes : Int?
    
    required init(map: Mapper) throws {
        try super.init(map: map)
        try totalEpisodes = map.from("total_episodes")
    }
    
    func fetch() {
        
    }
}
