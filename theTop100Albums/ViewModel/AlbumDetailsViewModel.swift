//
//  AlbumDetailsViewModel.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation
import SwiftUI

class AlbumDetailsViewModel : ObservableObject {
    @Published var albumDetails : AlbumsAPIResponse.Feed.Result?
    @Published var number : Int = 0
    ///
    func getAlbumDetails(id: String, viewModel: AlbumsViewModel) {
        if viewModel.albumsAPIResponse == nil {
            return
        }
        ///
        var n = 1
        ///
        for album in viewModel.albumsAPIResponse!.feed.results {
            if album.id == id {
                self.albumDetails = album
                self.number = n
                break
            }
            n += 1
        }
    }

}
