import Foundation

struct ItemModel {
    
    private var numberTxt: String = ""
    private var commaExists = false
    private let capacity = 9
    private let comma = 13
    
    init(){ }
    
    init(txt: String){
        numberTxt = txt
    }
    
    var textPresentation: String? {
        if self.numberTxt.isEmpty{
            return nil
        }
        return self.numberTxt
    }

    var doubleNum: Double {
        return Double(self.numberTxt) ?? 0
    }
    
    mutating func appendDigit(sender: Int){
        if !sizeCheck(){
            return
        }
        
        if sender != comma{
            numberTxt += "\(sender)"
        } else {
            guard !commaExists else { return }
            
            if numberTxt.isEmpty{
                numberTxt += "0."
            }else{
                numberTxt += "."
            }
            commaExists = true
        }
    }
    
    mutating func cleanNumberTxt(){
        self.numberTxt = ""
    }
    
    mutating func changeSign(){
        guard let _ = self.textPresentation else { return }
        var number = Double(self.numberTxt) ?? 0.0
        number *= -1
        self.numberTxt = convertDoubleIntoString(input: number)
    }
    
    private func sizeCheck() -> Bool{
           return self.numberTxt.count < capacity 
    }
    
    private func convertDoubleIntoString(input: Double) -> String{
        if input.truncatingRemainder(dividingBy: 1) == 0.0 {
            return  "\(Int(input))"
        } else {
            return  "\(input)"
        }
    }
}

extension ItemModel{
    static func == (f: ItemModel, s: ItemModel) ->Bool {
        return f.textPresentation == s.textPresentation
    }
}
