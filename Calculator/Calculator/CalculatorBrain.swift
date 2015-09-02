import Foundation

class CalculatorBrain {
    
    private enum Op: CustomStringConvertible {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)

        var description: String {
            switch self {
            case .Operand(let operand):           return "\(operand)"
            case .UnaryOperation(let symbol,  _): return symbol
            case .BinaryOperation(let symbol, _): return symbol
            }
        }

    }
    
    private var opStack = [Op]()
    private var knownOps = [String:Op]()

    init(){
        knownOps["+"]    = .BinaryOperation("+", + )
        knownOps["*"]    = .BinaryOperation("*", * )
        knownOps["-"]    = .BinaryOperation("-", { $1 - $0 } )
        knownOps["/"]    = .BinaryOperation("/", { $1 / $0 } )
        knownOps["sqrt"] = .UnaryOperation("sqrt", sqrt )

    }
    
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case Op.Operand(let operand): return (operand, remainingOps)
            case Op.UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case Op.BinaryOperation(_, let operation):
                let operandEvaluation1 = evaluate(remainingOps)
                if let operand1 = operandEvaluation1.result {
                    let operandEvaluation2 = evaluate(operandEvaluation1.remainingOps)
                    if let operand2 = operandEvaluation2.result {
                        return (operation(operand1, operand2), operandEvaluation2.remainingOps)
                    }
                }

            }
        }
        return (nil, ops)
    }
    
    func pushOperand(operand: Double) -> Double?{
        opStack.append(Op.Operand(operand))
        print("---------stack=\(opStack)")
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
            print("---------stack=\(opStack)")
        }
        return evaluate()
    }
    
    func clear() {
        opStack = [Op]()
    }
    
}