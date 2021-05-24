//
//  Constants.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation
import SwiftUI

///
///  Constants Data Table
///
struct Constants {
    /// API
    static let Scheme = "https"
    static let Host = "rss.itunes.apple.com"
    static let Path = "/api/v1/us/apple-music/top-albums/all/100"
    static let Req = "/explicit.json"
    
    /// Label, Title & Image Name
    static let Top100AlbumLabel = "Top 100 Albums List"
    static let AlbumDetailsLabel = "Top 100 Album Details"

    static let PlaceholderImage = "icloud.and.arrow.down"
    ///
    static let AlbumLabel = "Album:    "
    static let ArtistLabel = "Artist:   "
    static let GenreLabel = "Genre:    "
    static let ReleaseDateLabel = "Release:  "
    static let CopyrightLabel = "Copyright: "
    static let ItunesStoreLabel = "Open iTunes Store Page"

    /// Font Size
    static let TitleFont : CGFloat = 22.0
    static let BodyFont : CGFloat = 16.0
    static let CaptionFont : CGFloat = 14.0
    
    /// Image Layout
    static let ImageAspectRatio : CGFloat = 1.0

    /// Thumbnail
    static let ThumbnailHeight : CGFloat = 150.0
    static let Left = 0
    static let Right = 1

    /// Details
    static let LargeImageHeight : CGFloat = 400.0
}
