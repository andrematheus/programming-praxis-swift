import Foundation
import XCTest
import RpnCalculator

public class RpnCalculatorTests: XCTestCase {
    func testSiteExample() {
        let calculator = RpnCalculator()
        calculator.evaluate("19 2.14 + 4.5 2 4.3 / - *")
        XCTAssertEqual(calculator.top!, 85.2974, accuracy: 0.0001)
    }
    
    func testErrorKeepsPreviousStack() {
        let calculator = RpnCalculator()
        calculator.evaluate("1")
        XCTAssertEqual(calculator.top!, 1)
        calculator.evaluate("+")
        XCTAssertEqual(calculator.lastError, OperationError.StackHasNotEnoughOperands(2, 1))
        XCTAssertEqual(calculator.top!, 1)
    }
}
