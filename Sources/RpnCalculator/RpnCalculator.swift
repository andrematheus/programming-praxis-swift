import Foundation

public enum OperationError: Error, LocalizedError, Equatable {
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
    { (originalStack: [Double]) in
        var stack = originalStack
        if let y = stack.popLast(),
           let x = stack.popLast() {
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
        let operationsBySymbol: [String:(Double, Double) -> Double] = [
            "+": (+),
            "-": (-),
            "*": (*),
            "/": (/)
        ]

        for (symbol, operation) in operationsBySymbol {
            operations[symbol] = binaryOperation(operation)
        }
    }

    public var top: Double? {
        stack.last
    }

    private(set) public var lastError: OperationError?

    public func evaluate(_ input: String) {
        for token in input.split(separator: " ") {
            if let operation = operations[String(token)] {
                do {
                    let stack = try operation(self.stack)
                    self.stack = stack
                } catch let error as OperationError {
                    print(error.localizedDescription)
                    self.lastError = error
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