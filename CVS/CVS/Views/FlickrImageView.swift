
import SwiftUI

struct FlickrImageView: View {
    var imageURLString: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageURLString)) { image in
            image
                .resizable()
                .clipShape(.buttonBorder)
        } placeholder: {
            Image(systemName: "photo.fill")
                .resizable()
        }
        .aspectRatio(contentMode: .fill)
    }
}

#Preview {
    let flickrResult = FlickrResultViewModel().testResult.items[0]
    return FlickrImageView(imageURLString: flickrResult.media.imageString)
}
