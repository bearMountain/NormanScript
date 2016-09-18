



import XCTest

class NormanScriptTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddSVGTags() {
        let body = "sample body"
        let full = body.addSVGTags()
        let expectedResult = "<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">\nsample body\n</svg>"
        
        XCTAssertEqual(expectedResult, full)
    }
    
}
