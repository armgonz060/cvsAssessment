
import SwiftUI

fileprivate enum Constants {
    static let padding: CGFloat = 10
    static let spacing: CGFloat = 10
    static let cornerRadius: CGFloat = 25
}

struct FlickrResultGrid: View {
    @ObservedObject private var resultViewModel = FlickrResultViewModel()
    @State private var isPortrait: Bool = UIDevice.current.orientation.isPortrait
    @State private var searchQuery = ""
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 3
    )
    
    private var frameHeightDivider: CGFloat {
        isPortrait ? 5 : 3
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                let frameHeight: CGFloat = geometry.size.height / frameHeightDivider
                ScrollView {
                    LazyVGrid(columns: columns, spacing: Constants.spacing) {
                        ForEach(resultViewModel.flickrResultItems) { item in
                            GridRow(alignment: .center) {
                                NavigationLink {
                                    FlickrResultItem(item: item)
                                } label: {
                                    FlickrImageView(url: item.media.imageString) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .frame(height: frameHeight)
                                            .clipShape(.rect(cornerRadius: Constants.cornerRadius))
                                            .accessibilityLabel("Photo title: \(item.title)")
                                            .accessibilityHint("Tap to view details about photo")
                                            .accessibilityAddTraits(.isButton)
                                    } placeholder: {
                                        ProgressView()
                                            .accessibilityLabel("Loading image...")
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Flickr Search")
                .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
                .animation(.easeInOut, value: resultViewModel.flickrResultItems)
                .accessibilityHint("Enter keywords to search for Flickr photos")
                .onChange(of: searchQuery) {
                    Task {
                        await resultViewModel.searchFlickr(for: searchQuery)
                    }
                }
                .onAppear {
                    updateOrientation()
                    print("Is portrait: \(isPortrait)")
                }
                .onReceive(NotificationCenter.default.publisher(
                    for: UIDevice.orientationDidChangeNotification
                )) { _ in
                    updateOrientation()
                }
            }
        }
    }
    
    private func updateOrientation() {
        let orientation = UIDevice.current.orientation
        if orientation.isValidInterfaceOrientation {
            isPortrait = orientation.isPortrait
            print(isPortrait)
        }
    }
}

#Preview {
    FlickrResultGrid()
}
