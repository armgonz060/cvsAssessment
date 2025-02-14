
import SwiftUI

struct FlickrGridRowItem: View {
    var item: FlickrItem
    
    var body: some View {
        VStack(alignment: .center) {
            FlickrImageView(imageURLString: item.media.imageString)
                .frame(maxHeight: .infinity)
                .aspectRatio(contentMode: .fit)
            Text(item.title)
                .font(.title2)
        }
    }
}

#Preview {
    let flickrItem = FlickrResultViewModel().testResult.items[0]
    return FlickrGridRowItem(item: flickrItem)
}
