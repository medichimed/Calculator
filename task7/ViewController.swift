import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var labelOutlet: UILabel!
    @IBOutlet weak var acButtonOutlet: ActionButton!
    @IBOutlet weak var anotherLabelOutlet: UILabel!
    
    //MARK: - Properties
    var brains = Brains()
    var format = Formatter()
    
    private var acButtonState = ACButtonState.acState {
           didSet {
               acButtonOutlet.setTitle(acButtonState.buttonTitle, for: .normal)
           }
       }

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    //MARK: - Actions
    @IBAction func numberClicked(_ sender: NumberButton) {
        if acButtonState != .cState{
            acButtonState = .cState
        }
        brains.passNumbers(number: sender.number)
        updateUI()
    }
    
    @IBAction func actionChosen(_ sender: ActionButton) {
        if sender.actionToDo == .ac{
            acButtonState = .acState
            brains = Brains()
        }else{
            brains.doMathOperations(sender.actionToDo)
        }
        updateUI()
    }
    
    private enum ACButtonState {
        case acState, cState

        var buttonTitle: String {
            switch self {
            case .acState: return "AC"
            case .cState: return "C"
            }
        }
    }
    
}
    
private extension ViewController {
    func updateUI(){
        labelOutlet.text = format.formatInput(dataToDisplay: brains.value, enumerationSystem: Formatter.EnumSystem.decimal)
        anotherLabelOutlet.text = format.formatInput(dataToDisplay: brains.value, enumerationSystem: Formatter.EnumSystem.hexadecimal)
    }
}

