import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userIsINTheMiddleOfTypingANumber = false
    var operandStack = Array<Double>()
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsINTheMiddleOfTypingANumber = false
        }
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        print("------digit=\(digit)")
        if userIsINTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsINTheMiddleOfTypingANumber = true
        }
    }

    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsINTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "+"   : performOperation { $0 + $1 }
        case "-"   : performOperation { $0 - $1 }
        case "*"   : performOperation { $0 * $1 }
        case "/"   : performOperation { $0 / $1 }
        case "sqrt": performOperation { sqrt($0) }
        default: break
        }
    }
    
    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsINTheMiddleOfTypingANumber = false
//        operandStack.append(
//            display.text.flatMap {
//                number in NSNumberFormatter().numberFromString(number)
//            }!.doubleValue
//        )
        operandStack.append(displayValue)
        print("-------operandStack=\(operandStack)")
    }

    
    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }


}

