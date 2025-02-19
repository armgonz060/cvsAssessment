
import XCTest
@testable import FlickrAssessment

final class FlickrAssessmentTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_formatDate_Result_IsEmpty_False() {
        let testDate = "2025-02-09T22:22:39Z"
        
        XCTAssertFalse(testDate.formatDate().isEmpty, "Formatting string date returns empty value")
    }
    
    func test_formatDate_Result_FormattedDate_True() {
        let testDate = "2025-02-09T22:22:39Z"
        let formattedDate = "2025-02-09"
        
        XCTAssertTrue(testDate.formatDate() == formattedDate, "Converting string date to formatted date failed")
    }
    
    func test_convertHTMLToPlainText_Result_NotEmpty_True() {
        let htmlString = " <p><a href=\"https://www.flickr.com/people/crobart/\">crobart</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/crobart/54309724412/\" title=\"AAL_2920\"><img src=\"https://live.staticflickr.com/65535/54309724412_86b5f10484_m.jpg\" width=\"160\" height=\"240\" alt=\"AAL_2920\" /></a></p> "
        
        XCTAssertFalse(htmlString.htmlToPlainText().isEmpty, "Coverting string with html to formatted string failed")
    }

}
