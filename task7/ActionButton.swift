import UIKit

@IBDesignable class ActionButton: RoundCorneredButton {
    
    public var actionToDo = Action.none

    @IBInspectable private var action: String = " " {
        didSet {
            actionToDo = Action(rawValue: action) ?? .none
        }
    }
    
    enum Action: String {
        case none
        case equals = "="
        case addition = "+"
        case subtraction = "-"
        case devision = "/"
        case multiplication = "*"
        case modulo = "%"
        case changeSign = "+/-"
        case ac = "ac"
        
        var isMathAction: Bool{
            switch self{
            case .addition, .subtraction, .multiplication, .devision: return true
            default: return false
            }
        }
    }
    
}

