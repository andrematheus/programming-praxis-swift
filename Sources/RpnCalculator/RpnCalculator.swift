import Foundation

enum OperationError: Error, LocalizedError {
    case StackHasNotEnoughOperands(Int, Int)
    public var errorDescription: String? {
        switch self {
        case .StackHasNotEnoughOperands(let required, let actual):
            return NSLocalizedString("Operation requires \(required) parameters but received \(actual).", comment: "")
        }
    }
}

typealias Operation = ([Double]) throws -> [Double]

func binaryOperation(_ op: @escaping  (Double, Double) -> Double) -> Operation {
    return { (originalStack: [Double]) in
        var stack = originalStack
        if let x = stack.popLast(),
           let y = stack.popLast() {
            let z = op(x, y)
            stack.append(z)
            return stack
        } else {
            throw OperationError.StackHasNotEnoughOperands(2, originalStack.count)
        }
    }
}

public class RpnCalculator {
    var stack: [Double] = []
    var operations: [String: Operation] = [:]

    public init() {
        operations["+"] = binaryOperation { x, y in
            y + x
        }
        operations["-"] = binaryOperation { x, y in
            y - x
        }
        operations["*"] = binaryOperation { x, y in
            y * x
        }
        operations["/"] = binaryOperation { x, y in
            y / x
        }
    }

    public var top: Double? {
        return stack.last
    }

    public func evaluate(_ input: String) {
        for token in input.split(separator: " ") {
            if let operation = operations[String(token)] {
                do {
                    let stack = try operation(self.stack)
                    self.stack = stack
                } catch let err where err is OperationError {
                    print(err.localizedDescription)
                } catch {
                    print("Unknown error.")
                }
            } else if let operand = Double(token) {
                stack.append(operand)
            } else {
                print("Invalid token: \(token)")
            }
        }
    }
}