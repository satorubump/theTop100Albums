//
//  AlbumDetailsView.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import SwiftUI

///
///  Display Album Details
///
struct AlbumDetailsView: View {
    @ObservedObject var detailsViewModel = AlbumDetailsViewModel()
    @EnvironmentObject var viewModel : AlbumsViewModel
    ///
    var album : AlbumCell?
    ///
    init(album: AlbumCell) {
        ///
        print("AlbumDetailsView init")
        if (album != nil) {
            self.album = album
        }
    }
    ///
    var body: some View {
        ///
        VStack {
            ///
            if detailsViewModel.albumDetails != nil && self.album != nil {
                self.albumDetailsSection
                ///
                Spacer()
                self.iTunesButtonSection
                    .padding(.bottom, 20.0)
            }
        }
        .navigationBarTitle(Constants.AlbumDetailsLabel, displayMode: .inline)

        .onAppear() {
            if (self.album != nil) {
                self.detailsViewModel.getAlbumDetails(id: self.album!.id, viewModel: self.viewModel)
            }
        }
    }
}

///
///  View Seciotns for Album Details
///
private extension AlbumDetailsView {
    ///
    ///  Display Album Detials
    ///
    var albumDetailsSection : some View {
        VStack {
            /// Large Image
            URLImage(url: album!.artworkUrl100, height: Constants.LargeImageHeight)
            /// Information List
            self.albumDetailsList
        }
    }
    ///
    ///  Display Album Details Information List
    ///
    var albumDetailsList : some View {
        ///
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    Text("No." + String(self.detailsViewModel.number) + " ")
                    Text(self.detailsViewModel.albumDetails!.name)
                }
                .foregroundColor(Color.darkGray)
                .font(.system(size: Constants.TitleFont))
                .padding(.top, 5.0)
                HStack(alignment: .top) {
                    Text(self.detailsViewModel.albumDetails!.artistName)
                        .font(.system(size: Constants.TitleFont))
                        .foregroundColor(Color.darkGray)
                }
                .padding(.top, 2.0)

                List {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(Constants.GenreLabel)
                        }
                        .frame(width: 100)
                        ForEach(self.detailsViewModel.albumDetails!.genres.indices, id: \.self) { index in
                            if index > 0 {
                                Text(" ")
                            }
                            Text(self.detailsViewModel.albumDetails!.genres[index].name)
                        }
                    }
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                        Text(Constants.ReleaseDateLabel)
                        .frame(width: 100)
                        }
                        Text(self.detailsViewModel.albumDetails!.releaseDate)
                    }
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                        Text(Constants.CopyrightLabel)
                        .frame(width: 100)
                    }
                    Text(self.detailsViewModel.albumDetails!.copyright)
                }
            }
                .frame(width: 400, alignment: .leading)
                .font(.system(size: Constants.BodyFont))
                .foregroundColor(Color.gray)

                Spacer()
        
        }
    }
    ///
    var iTunesButtonSection : some View {
        ///
        VStack {
            Link(Constants.ItunesStoreLabel, destination: URL(string: self.detailsViewModel.albumDetails!.url)!)
        }
    }
}
