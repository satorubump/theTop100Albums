//
//  AlbumsViewModel.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation
import SwiftUI
import Combine

///
///  Albums View Model
///
class AlbumsViewModel : ObservableObject {
    @Published var albumLines = [AlbumLine]()
    
    ///
    var albumsAPIResponse : AlbumsAPIResponse? {
        didSet {
            if albumsAPIResponse != nil {
                self.updateAlbumLines()
            }
        }
    }

    private let feedAPI = FeedGeneratorAPI()
    private var disposables = Set<AnyCancellable>()

    ///
    ///  Fetch Albums Data Subscriber
    ///
    func downloadAlbums() {
        feedAPI.fetchAlbumsData()
            /// Receive on Main Thread
            .receive(on: DispatchQueue.main)
            /// Received Data in A Sincronize
            .sink(
                /// Get the Failure / Success
                receiveCompletion: { [weak self] value in
                    guard let self = self else { print("sink guard nil"); return }
                    switch value {
                    /// Error
                    case .failure:
                        self.albumsAPIResponse = nil
                    /// Success
                    case .finished:
                        break
                    }
                },
                /// Receive Response Data
                receiveValue: { [weak self] albumResponse in
                    self!.albumsAPIResponse = albumResponse
                })
            .store(in: &disposables)
    }
    
    ///
    ///  Update Albums Data for Thumbnails Presentor
    ///
    func updateAlbumLines() {
        ///
        var lid = 0
        var index = 0
        let count = self.albumsAPIResponse!.feed.results.count
        
        ///
        ///  from AlbumsAPIResponse.feed.results to AlbumLines
        ///
        while(true) {
            if index >= count {
                break
            }
            var album = self.albumsAPIResponse!.feed.results[index]
            let cell1 = AlbumCell(id: album.id, name: album.name, artistName: album.artistName, artworkUrl100: album.artworkUrl100)
            index += 1
            if index >= count {
                break
            }
            album = self.albumsAPIResponse!.feed.results[index]
            let cell2 = AlbumCell(id: album.id, name: album.name, artistName: album.artistName, artworkUrl100: album.artworkUrl100)
            index += 1
            let albumLine = AlbumLine(id: lid, left: cell1, right: cell2)
            self.albumLines.append(albumLine)
            lid += 1
        }
    }
}
