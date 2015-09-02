import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    var userIsINTheMiddleOfTypingANumber = false
    let brain = CalculatorBrain()
    
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
        if userIsINTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation( operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsINTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand( displayValue ) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }

    
    @IBAction func evaluate() {
        if(userIsINTheMiddleOfTypingANumber) {
            enter()
        }
        if let result = brain.evaluate() {
            print("-------result=\(result)")
            displayValue = result
        }
        
    }
    
    @IBAction func clear() {
        brain.clear()
        displayValue = 0
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

