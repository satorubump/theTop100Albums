//
//  theTop100AlbumsApp.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import SwiftUI

@main
struct theTop100AlbumsApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AlbumsViewModel()
            AlbumThumbnailsView(viewModel: viewModel)
        }
    }
}
