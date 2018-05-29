import RpnCalculator

let calculator = RpnCalculator()

while let input = readLine(strippingNewline: true) {
    calculator.evaluate(input)
    print(calculator.top ?? "Stack empty.")
}
