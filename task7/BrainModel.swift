import Foundation

struct Brains {
    typealias Action = ActionButton.Action
    
    //MARK: - Properties
    private var first = ItemModel()
    private var second = ItemModel()

    private var constOperand = ItemModel()
    
    private var result: Double = 0.0
    private let maxLength = 9
    
    private var actionToPerform = Action.none
    private var copyOfAction = Action.none
    
    private var state = State.first
    private var isError = false
    private var setConstantOperand = false
    
    var currentOperand: ItemModel {
        get{
            switch state {
           case .first, .result:
               return first
           case .second:
            if second.textPresentation == nil{
                return first
            }
            return second
            }
        }
        set{
            switch state{
            case .second: second = newValue
            default: first = newValue
            }
        }
    }
    
    enum BrainsResult{
        case error
        case result(Double)
    }
    
    var value: BrainsResult{
        if isError{
            return .error
        }else{
            return .result(currentOperand.doubleNum)
        }
    }

    //MARK: - Functionality
    mutating func passNumbers(number: Int){
        
        if isError{
            return
        }
        
        switch state{
        case .first: first.appendDigit(sender: number)
        case .second: second.appendDigit(sender: number)
        case .result:
            state = .first
            first.cleanNumberTxt()
            first.appendDigit(sender: number)
        }
    }

    mutating func performAction(operation: Action){
        let firstNumber = first.doubleNum
        var secondNumber = second.doubleNum

        if actionToPerform == .equals{
            secondNumber = constOperand.doubleNum
        }

        do {
            result = try performMath(operation: operation, first: firstNumber, second: secondNumber)
        } catch {
            result = 0.0
            isError = true
        }
    }
    
    private mutating func performMath(operation: Action, first: Double ,second: Double) throws -> Double {
        switch operation {
        case .addition: return first + second
        case .subtraction:
            var result = first - second
            fixPossibleSubtractionIssues(target: second, result: &result)
            return result
        case .multiplication: return first * second
        case .devision:
            if second == 0.0{
                throw MyErrors.devisionByZero
            }
        return first / second
        default: throw MyErrors.crucialError
        }
    }
    
    mutating func doMathOperations(_ action: Action){
        
        guard !isError else { return }
        
        if action == .changeSign{
            if state == .result{
                state = .first
            }
            currentOperand.changeSign()
        } else if action == .modulo {
            calculateModulo(operand: currentOperand)
        } else if action.isMathAction {
            if state == .second{
                performAction(operation: actionToPerform)
                first = ItemModel(txt: convertDoubleIntoString(input: result))
                second.cleanNumberTxt()
            }else{
                state = .second
            }
            actionToPerform = action
            copyOfAction = action
        }else if action == .equals {
            if actionToPerform != .equals && !setConstantOperand{
                constOperand = ItemModel(txt: second.textPresentation ?? first.textPresentation!)
                setConstantOperand = true
                actionToPerform = .equals
            }
            performAction(operation: copyOfAction)
            first = ItemModel(txt: convertDoubleIntoString(input: result))
            second.cleanNumberTxt()
            state = .result
            }
    }
    
    mutating func calculateModulo(operand: ItemModel){
        guard let _ = operand.textPresentation else { return }
        if actionToPerform == .none || state == .result || state == .first{
            first = ItemModel(txt: convertDoubleIntoString(input: operand.doubleNum / 100))
        }else{
            if actionToPerform == .addition || actionToPerform == .subtraction{
                second = ItemModel(txt:convertDoubleIntoString(input: first.doubleNum * (operand.doubleNum / 100)))
            }else if actionToPerform == .multiplication || actionToPerform == .devision{
                second = ItemModel(txt: convertDoubleIntoString(input: operand.doubleNum / 100))
            }
        }
    }
    
    private  mutating func fixPossibleSubtractionIssues(target: Double, result: inout Double){
        if !convertDoubleIntoString(input: target).contains("."){
            let strResult = result.format(f: ".1")
            result = Double(strResult)!
        }
    }
    
    private mutating func convertDoubleIntoString(input: Double) -> String{
        if input.truncatingRemainder(dividingBy: 1) == 0.0 {
            if isTooBigResult(){
                isError = true
                return "Fytu-nytu"
            }
            return  "\(Int(input))"
        } else {
            if isTooBigResult(){
                let holder = Array(String(input))
                let result = Array(holder[0..<10])
                return String(result)
            }
            return  "\(input)"
        }
    }
    
    private enum State{
        case first
        case second
        case result
    }
    
    private enum MyErrors: Error {
        case devisionByZero
        case crucialError
    }
    
     private  func isTooBigResult() -> Bool {
        return String(result).count > maxLength
    }
}

extension Double{
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
