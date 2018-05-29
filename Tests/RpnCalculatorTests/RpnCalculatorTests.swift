import Foundation
import XCTest
import RpnCalculator

public class RpnCalculatorTests: XCTestCase {
    public static var allTests = [
        ("testSiteExample", testSiteExample)
    ]

    func testSiteExample() {
        let calculator = RpnCalculator()
        calculator.evaluate("19 2.14 + 4.5 2 4.3 / - *")
        XCTAssertEqual(calculator.top!, 85.2974, accuracy: 0.0001)
    }
}
