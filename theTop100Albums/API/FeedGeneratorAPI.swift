//
//  FeedGeneratorAPI.swift
//  theTop100Albums
//
//  Created by Satoru Ishii on 5/22/21.
//

import Foundation
import Combine

///  API Error
///
enum APIError: Error {
    case network(description: String)
    case decoding(description: String)
}

///
///  FetchableAlbumsData Protocol
///
/// - Functions:
///   - fetchAlbumList(title: String) return success; AlbumAPIResponse, fail: APIError
///
protocol FetchableAlbumsData {
    func fetchAlbumsData() -> AnyPublisher<AlbumsAPIResponse, APIError>
}
///
///  Feed Generator API Fetcher
///
class FeedGeneratorAPI : FetchableAlbumsData {
    ///
    /// Fetch Top 100 Albums
    ///
    /// - Parameters:
    ///
    /// - Returns: AnyPublisher Success:  AlbumsAPIResponse Publish, Falise: APIError
    ///
    func fetchAlbumsData() -> AnyPublisher<AlbumsAPIResponse, APIError> {
        let urlComponents = self.makeAlbumsRequestUrl()
        return fetchPublisher(components: urlComponents)
    }
    ///
    /// Create the Top 100 Albums Request URL
    ///
    /// - Parameters:
    ///
    /// - Returns: URLComponents -- URL Request
    ///
    private func makeAlbumsRequestUrl() -> URLComponents {
        var urlComp = URLComponents()
        urlComp.scheme = Constants.Scheme
        urlComp.host = Constants.Host
        urlComp.path = Constants.Path + Constants.Req
        ///
        return urlComp
    }
    
    ///
    ///  Fetch Publiser for Feed Generator  API, Downloading and Publish the Albums Data (Combine)
    ///
    /// - Parameters:
    ///  - paramA: URLRequest : URLCompnents
    ///
    /// - Returns:  Any Publisher Success: AlbumsAPIResponse Publsh, Fail: APIError
    ///
    private func fetchPublisher(components: URLComponents) -> AnyPublisher<AlbumsAPIResponse, APIError> {
        guard let url = components.url else {
            let error = APIError.network(description: "Can't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
    
    ///
    /// Decode json data to AlbumsAPIResponse codable struct data
    ///
    /// - Parameters:
    ///   - paramA: download json data
    ///
    /// - Returns: Decode success: AlbumsAPIResponse Publish, fails: APIError
    ///
    private func decode(_ data: Data) -> AnyPublisher<AlbumsAPIResponse, APIError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return Just(data)
            .decode(type: AlbumsAPIResponse.self, decoder: decoder)
            .print()
            .mapError { error in
                .decoding(description: error.localizedDescription)
            }
          .eraseToAnyPublisher()
    }
}
