//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum Op {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)
    case BinaryOperation(String, (Double, Double) -> Double)
}

let op1 = Op.Operand( 5 )

"\(op1)"
