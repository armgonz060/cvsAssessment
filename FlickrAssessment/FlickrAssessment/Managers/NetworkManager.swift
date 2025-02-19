
import Foundation

fileprivate enum Constants {
    static let baseURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=%@"
}

enum NetworkError: Error {
    case invalidURL(string: String)
}

class NetworkManager {
    static let shared = NetworkManager()
    private let session = URLSession.shared
    private let urlCache = URLCache.shared
    
    private init() {}
    
    func load<T: Decodable>(tags: String) async throws -> T {
        let urlString = String(format: Constants.baseURL, tags)
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(string: urlString)
        }
        let urlRequest = URLRequest(url: url)
        
        if let cachedResponse = urlCache.cachedResponse(for: urlRequest) {
            print("Displaying cached response for: '\(tags)'")
            let decodedData = try JSONDecoder().decode(T.self, from: cachedResponse.data)
            return decodedData
        }
        
        let (data, response) = try await session.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
            let cachedResponse = CachedURLResponse(response: response, data: data)
            urlCache.storeCachedResponse(cachedResponse, for: urlRequest)
            print("Caching response for: '\(tags)'")
        }
        
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }
}
