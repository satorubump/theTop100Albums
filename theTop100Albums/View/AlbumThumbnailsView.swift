//
//  AlbumThumbnailsView.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import SwiftUI

///
///  Album Thumbnail Cells View
///
struct AlbumThumbnailsView: View {
    @ObservedObject var viewModel : AlbumsViewModel
    ///
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
    }

    ///
    var body: some View {
        NavigationView {
            VStack {
                ///
                if self.viewModel.albumLines.count > 0 {
                    ScrollView {
                        self.albumListSection
                    }
                }
            }
            .navigationBarTitle(Constants.Top100AlbumLabel, displayMode: .inline)
        }
        
        .onAppear() {
            ///
            self.viewModel.downloadAlbums()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())

    }
}

///
///  View Sections for Album Thumbnail Cells View
///
private extension AlbumThumbnailsView {
    ///
    var albumListSection : some View {
        ///
            ForEach(self.viewModel.albumLines, id: \.lid) { albumLine in
                VStack {
                    HStack(alignment: .top) {
                        /// Left Thumbnail
                        VStack(alignment: .center) {
                            /// Thumbnail
                            NavigationLink(destination: AlbumDetailsView(album: albumLine.albumCells[Constants.Left])
                                            .environmentObject(self.viewModel)) {
                                    URLImage(url: albumLine.albumCells[Constants.Left].artworkUrl100, height: Constants.ThumbnailHeight)
                            }
                            /// Album Name
                            Text(albumLine.albumCells[Constants.Left].name)
                                .foregroundColor(Color.darkGray)
                            /// Artist Name
                            Text(albumLine.albumCells[Constants.Left].artistName)
                                .foregroundColor(Color.gray)
                        }
                        .frame(width: 150)

                        /// Right Thumbnail
                        
                        VStack(alignment: .center) {
                            /// Thumbnail
                            NavigationLink(destination: AlbumDetailsView(album: albumLine.albumCells[Constants.Right])
                                            .environmentObject(self.viewModel)) {
                                    URLImage(url: albumLine.albumCells[Constants.Right].artworkUrl100, height: Constants.ThumbnailHeight)
                            }
                            .frame(width: 150)
                            /// Album Name
                            Text(albumLine.albumCells[Constants.Right].name)
                                .foregroundColor(Color.darkGray)
                            /// Artist Name
                            Text(albumLine.albumCells[Constants.Right].artistName)
                                .foregroundColor(Color.gray)
                        }
                        .frame(width: 150)

 
                   }
                    .font(.system(size: Constants.CaptionFont))
                }
            }
    }
}

struct AlbumThumbnailsView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumThumbnailsView(viewModel: AlbumsViewModel())
    }
}

///
extension Color {
    static let darkGray = Color(red: 76 / 255, green: 50 / 255, blue: 66 / 255)
//    static let darkGray = Color(red: 50 / 255, green: 66 / 255, blue: 76 / 255)
//    static let darkGray = Color(red: 64 / 255, green: 64 / 255, blue: 64 / 255)
}

