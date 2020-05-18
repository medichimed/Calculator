import Foundation

struct Formatter {
    
    private func checkForMinusSign(_ input: String) -> (hasMinus: Bool, num: String){
        if input.contains("-"){
            if input.contains("."){
                let num = Double(input)! * -1
                return (true, String(num))
            }else{
                let num = Int(input)! * -1
                return (true, String(num))
            }
        }
        return (false, input)
    }
    
    private func hexadecimalConvertationSignFree(_ input: String) -> String{
        if input.contains("."){
            var result = [String]()
            let wholePart = floor(Double(input)!)
            let fractionalPart = Double(input)!.truncatingRemainder(dividingBy: 1)
            result.append(String(Int(wholePart), radix: 16))
            result.append(".")
            
            var holder = fractionalPart
            while holder != 0.0{
                holder = holder * 16
                let whole = floor(holder)
                result.append(String(Int(whole), radix: 16))
                holder = holder.truncatingRemainder(dividingBy: 1)
            }
            return result.joined().uppercased()
        }else{
            let num = Int(input)!
            return String(num, radix: 16).uppercased()
        }
    }
    
    private func toHex(_ input: String) -> String{
            
        let (hasMinus, target) = checkForMinusSign(input)
        
        if hasMinus{
            return "-" + hexadecimalConvertationSignFree(target)
        }else{
            return hexadecimalConvertationSignFree(target)
        }
    }
    
    private mutating func convertDoubleIntoString(input: Double) -> String{
        if input.truncatingRemainder(dividingBy: 1) == 0.0 {
            return  "\(Int(input))"
        } else {
            return  "\(input)"
        }
    }
    
    mutating func formatInput(dataToDisplay: Brains.BrainsResult, enumerationSystem: EnumSystem) -> String{
        switch dataToDisplay{
        case .error: return "Error"
        case .result(let result):
            let target = convertDoubleIntoString(input: result)
            switch enumerationSystem{
            case .decimal: return target
            case .hexadecimal: return toHex(String(target))
            }
            }
        }
    
    enum EnumSystem{
        case decimal
        case hexadecimal
    }
}

