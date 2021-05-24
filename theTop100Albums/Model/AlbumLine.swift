//
//  AlbumLine.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation

///
///  Album Thumbnails Presentor
///
struct AlbumLine {
    ///
    let lid : Int
    var albumCells = [AlbumCell]()
    ///
    init(id: Int, left: AlbumCell, right: AlbumCell) {
        self.lid = id
        self.albumCells.append(left)
        self.albumCells.append(right)
    }
}

struct AlbumCell {
    let id : String
    let name : String
    let artistName : String
    let artworkUrl100 : String
}
