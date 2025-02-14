
import SwiftUI

struct FlickrResultItem: View {
    @State var item: FlickrItem
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Text(item.title)
                        .font(.title)
                    
                    FlickrImageView(imageURLString: item.media.imageString)
                    
                    HStack(alignment: .top) {
                        Text(item.author)
                            .font(.headline)
                        
                        Spacer()
                        
                        VStack {
                            Text("Height: \(item.imageDimensions.height), Width: \(item.imageDimensions.height)")
                            Text(item.dateTaken.formatDate())
                                .font(.subheadline)
                        }
                    }
                    
                    Divider()
                    
                    Text($item.formattedDescription.wrappedValue)
                         
                }
                .padding()
            }
        }
        .onAppear {
            Task {
                item.formattedDescription = item.description.htmlToPlainText()
            }
        }
    }
}

#Preview {
    let viewModel = FlickrResultViewModel()
    return FlickrResultItem(item: viewModel.testResult.items[0])
}
