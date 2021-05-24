//
//  AlbumsAPIResponse.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation

///
///  Albums Model for Feed Generator API Response
///
struct AlbumsAPIResponse : Codable {
    ///
    let feed : Feed
    enum CodingKeys : String, CodingKey {
        case feed
    }
    ///
    struct Feed : Codable {
        let results : [Result]
        enum CodingKeys : String, CodingKey {
            case results
        }
        ///
        struct Result : Codable {
            let id : String
            let name : String
            let artistName : String
            let artworkUrl100 : String
            let genres : [Genre]
            let releaseDate : String
            let copyright : String
            let url : String

            enum CodingKeys : String, CodingKey {
                case id
                case name
                case artistName
                case artworkUrl100
                case genres
                case releaseDate
                case copyright
                case url
            }
            ///
            struct Genre : Codable {
                let name : String
                enum CodingKeys : String, CodingKey {
                    case name
                }
            }
        }
    }
}
