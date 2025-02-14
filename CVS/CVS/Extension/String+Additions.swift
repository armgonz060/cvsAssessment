
import Foundation

extension String {
    func htmlToPlainText() -> String {
        guard let data = self.data(using: .utf8) else { return "" }
        
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            ).string
        } catch {
            print("Error converting HTML to NSAttributedString:", error)
            return ""
        }
    }
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        formatter.timeZone = TimeZone(abbreviation: "PST")

        let formattedDate: String
        if let date = formatter.date(from: self) {
            formatter.dateFormat = "yyyy-MM-dd" // New format without time
            formattedDate = formatter.string(from: date)
        } else {
            formattedDate = ""
        }
        return formattedDate
    }
}
