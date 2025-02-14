
import SwiftUI

fileprivate enum Constants {
    static let padding: CGFloat = 10
    static let spacing: CGFloat = 10
    static let cornerRadius: CGFloat = 25
}

struct FlickrResultGrid: View {
    @ObservedObject private var resultViewModel = FlickrResultViewModel()
    @State private var searchQuery = ""
    
    private let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 100, maximum: 300)), count: 2)
    
    var body: some View {
        NavigationSplitView {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass") // Search icon
                        .foregroundColor(.gray)
                        .padding(.leading, Constants.padding)
                    
                    TextField("Search", text: $searchQuery)
                        .padding(.leading, Constants.padding)
                        .onChange(of: searchQuery) {
                            Task {
                                resultViewModel.isLoading = true
                                await resultViewModel.searchFlickr(for: searchQuery)
                                resultViewModel.isLoading = false
                            }
                        }
                }
                .padding(.vertical, Constants.padding)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(Color.gray, lineWidth: 1)
                )
                    
                GeometryReader { geometry in
                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: Constants.spacing) {
                                ForEach(resultViewModel.flickrResultItems, id: \.id) { item in
                                    GridRow(alignment: .center) {
                                        NavigationLink {
                                            FlickrResultItem(item: item)
                                                .transition(.slide)
                                        } label: {
                                            FlickrGridRowItem(item: item)
                                        }
                                        .buttonStyle(.plain)
                                    }
                                    .frame(height: geometry.size.height / 4)
                                }
                            }
                        }
                        
                        if resultViewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                        }
                    }
                }
                .padding(.top, Constants.padding)
            }
        } detail: {
            Text("Select a landmark")
        }
        .padding()
    }
}

#Preview {
    FlickrResultGrid()
}
