
import SwiftUI

struct FlickrImageView<Content: View, Placeholder: View>: View {
    let url: String
    let transaction: Transaction
    let content: (Image) -> Content
    let placeholder: () -> Placeholder
    
    init(
        url: String,
        transaction: Transaction = Transaction(),
        @ViewBuilder imageContent: @escaping (Image) -> Content,
        @ViewBuilder placeholder: @escaping () -> Placeholder
    ) {
        self.url = url
        self.transaction = transaction
        self.content = imageContent
        self.placeholder = placeholder
    }
    
    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(
                url: url,
                transaction: transaction
            ) { phase in
                switch phase {
                case .empty:
                    placeholder()
                case .success(let image):
                    content(image)
                        .transition(.opacity.combined(with: .scale))
                case .failure:
                    Color.gray
                        .overlay {
                            Image(systemName: "photo.fill")
                                .foregroundStyle(.white)
                        }
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            placeholder()
        }
    }
}
