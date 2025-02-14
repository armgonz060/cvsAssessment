import Foundation
 
struct FlickrResult: Codable, Hashable {
    var title: String = ""
    var link: String = ""
    var description: String = ""
    var modified: String = ""
    var generator: String = ""
    var items: [FlickrItem] = []
}

struct FlickrItem: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString
    var authorId: String
    var title: String
    var link: String
    var media: FlickrMedia
    var dateTaken: String
    var description: String
    var published: String
    var author: String
    var tags: String
    var formattedDescription: String = ""
    lazy var imageDimensions: (height: String, width: String) = getImageDimensions()
    
    private func getImageDimensions() -> (String, String) {
        let dimensionsArray = description.components(separatedBy: " ").filter{ $0.contains("width") || $0.contains("height") }
        
        var imageDimensions = (height: "", width: "")
        for dimension in dimensionsArray {
            let tempDimension = dimension.filter{ $0.isNumber }.map{ String($0) }.joined()
            if dimension.contains("width") {
                imageDimensions.width = tempDimension
            } else {
                imageDimensions.height = tempDimension
            }
        }
        return imageDimensions
    }
    
    private enum CodingKeys: String, CodingKey {
        case authorId = "author_id"
        case title
        case link
        case media
        case dateTaken = "date_taken"
        case description
        case published
        case author
        case tags
    }
}

struct FlickrMedia: Codable, Hashable {
    var imageString: String
    
    enum CodingKeys: String, CodingKey {
        case imageString = "m"
    }
}
