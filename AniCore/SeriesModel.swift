//
//  SeriesModel.swift
//  AniCore
//
//  Created by Kyle Brown on 10/04/2017.
//  Copyright © 2017 Kyle Brown. All rights reserved.
//

import Foundation
import Mapper

enum mediaTypes {
    case TV
    case TVShort
    case Movie
    case Special
    case OVA
    case ONA
    case Music
    case Manga
    case Novel
    case OneShot
    case Doujin
    case Manhua
    case Manhwa
}

class SeriesModel : Mappable {
    
    var seriesID : Int?
    var seriesType : String?
    var titleEnglish : String?
    var titleJapanese : String?
    var type : String?
    var startDate : String?
    var endDate : String?
    
    required init(map: Mapper) throws {
        try seriesID = map.from("id")
        try seriesType = map.from("series_type")
        try titleEnglish = map.from("title_english")
        try titleJapanese = map.from("title_japanese")
        try type = map.from("type")
        try startDate = map.from("start_date_fuzzy")
        try endDate = map.from("end_date_fuzzy")
    }
    
}
