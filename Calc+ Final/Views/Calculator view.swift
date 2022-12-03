//
//  Calculator view.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/23/22.
//

import SwiftUI
enum numerator: String{
    case upZero  = "⁰"
    case upOne   = "¹"
    case upTwo   = "²"
    case upThree = "³"
    case upFour  = "⁴"
    case upFive  = "⁵"
    case upSix   = "⁶"
    case upSeven = "⁷"
    case upEight = "⁸"
    case upNine  = "⁹"
}
enum denominator: String{
    case downZero  = "₀"
    case downOne   = "₁"
    case downTwo   = "₂"
    case downThree = "₃"
    case downFour  = "₄"
    case downFive  = "₅"
    case downSix   = "₆"
    case downSeven = "₇"
    case downEight = "₈"
    case downNine  = "₉"
}

struct Calculator_view: View {
    
    @StateObject var detector: MotionDetector
    @State var upValue = "0"
    @State var value = "0"
    @State var currOpp = ""
    
    let calc = Calculator()
    let opps = ["+","−","×","÷"]
    
    // Variables for fractions
    @State var typingNumerator = false
    @State var typingDenominator = false
    @State var typingaFractionState = 0
    
    var body: some View {
        
        VStack{
            
            ZStack{
                
                HStack{
                    Image("menu").padding(.leading)
                    Spacer()
                    
                }
                
                Text("Calculator")
                
                    .font(.largeTitle).foregroundColor(.black)
            }
            
            VStack{
                
                Color(.white)
                    .frame(width: .infinity, height: 250)
                    .overlay(Text(self.upValue)
                        .font(.system(size: 35))
                             , alignment: .topTrailing)
                    .overlay(Text(self.value)
                        .bold()
                        .font(.system(size: 70))
                             , alignment: .bottomTrailing)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .padding()
                
            }.scaledToFill()
            
            HStack{
                
                Button(action: {
                    
                }, label: {Image("feetButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("inchButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("yardButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("copyButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("pasteButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {clear()
                    
                }, label: {Image("clearButton").resizable().scaledToFit()})
                
                Button(action: {
                    
                }, label: {Image("plusMinusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("percentButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {transferValue(opp: "÷")
                }, label: {Image("divideButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver2Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: numberFormater(number: "7"))
                    
                }, label: {Image("sevenButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "8"))
                    
                }, label: {Image("eightButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "9"))
                    
                }, label: {Image("nineButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(opp: "×")
                    
                }, label: {Image("multiplyButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver4Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: numberFormater(number: "4"))
                    
                }, label: {Image("fourButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "5"))
                    
                }, label: {Image("fiveButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "6"))
                    
                }, label: {Image("sixButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(opp: "−")
                    
                }, label: {Image("minusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver8Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: numberFormater(number: "1"))
                    
                }, label: {Image("oneButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "2"))
                    
                }, label: {Image("twoButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: numberFormater(number: "3"))
                    
                }, label: {Image("threeButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(opp: "+")
                    
                }, label: {Image("plusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver16Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: numberFormater(number: "0"))
                    
                }, label: {Image("zeroButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: ".")
                    
                }, label: {Image("pointButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {back()
                    
                }, label: {Image("deleteButton").resizable().scaledToFit()})
                
                Button(action: {equal()
                    
                }, label: {Image("equalButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {typingAFraction()
                    
                }, label: {Image("emptyFractionButton").resizable().scaledToFit()})
                
            }
        }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
    func typingAFraction(){
        if self.typingaFractionState == 0{
            self.typingNumerator = true
            self.typingaFractionState += 1
        }
        else if self.typingaFractionState == 1{
            if currOpp.isEmpty{
                
            }
            buttonTaped(number: "⁄")
            self.typingNumerator = false
            self.typingDenominator = true
            self.typingaFractionState += 1
        }
        else{
            self.typingNumerator = false
            self.typingDenominator = false
            self.typingaFractionState = 0
        }
    }
    
    func numberFormater(number: String)-> String{
        switch number{
        case "0":
            if self.typingNumerator{return numerator.upZero.rawValue}
            else if self.typingDenominator{return denominator.downZero.rawValue}
            else{return "0"}
            
        case "1":
            if self.typingNumerator{return numerator.upOne.rawValue}
            else if self.typingDenominator{return denominator.downOne.rawValue}
            else{return "1"}
            
        case "2":
            if self.typingNumerator{return numerator.upTwo.rawValue}
            else if self.typingDenominator{return denominator.downTwo.rawValue}
            else{return "2"}
            
        case "3":
            if self.typingNumerator{return numerator.upThree.rawValue}
            else if self.typingDenominator{return denominator.downThree.rawValue}
            else{return "3"}
            
        case "4":
            if self.typingNumerator{return numerator.upFour.rawValue}
            else if self.typingDenominator{return denominator.downFour.rawValue}
            else{return "4"}
            
        case "5":
            if self.typingNumerator{return numerator.upFive.rawValue}
            else if self.typingDenominator{return denominator.downFive.rawValue}
            else{return "5"}
            
        case "6":
            if self.typingNumerator{return numerator.upSix.rawValue}
            else if self.typingDenominator{return denominator.downSix.rawValue}
            else{return "6"}
            
        case "7":
            if self.typingNumerator{return numerator.upSeven.rawValue}
            else if self.typingDenominator{return denominator.downSeven.rawValue}
            else{return "7"}
            
        case "8":
            if self.typingNumerator{return numerator.upEight.rawValue}
            else if self.typingDenominator{return denominator.downEight.rawValue}
            else{return "8"}
            
        case "9":
            if self.typingNumerator{return numerator.upNine.rawValue}
            else if self.typingDenominator{return denominator.downNine.rawValue}
            else{return "9"}
            
        default:
            return ""
        }
    }
    
    func clear(){
        //self.numLock = false
        self.typingNumerator = false
        self.typingDenominator = false
        self.typingaFractionState = 0

        if self.value == "0"{
            self.upValue = "0"
        }
        else{
            self.value = "0"
        }
        
    }
    
    func back(){
        if (!self.upValue.contains("+")  || !self.upValue.contains("−")  || !self.upValue.contains("×")  || !self.upValue.contains("÷")) &&
            self.value == "0"
        {
            self.currOpp = ""
            self.value.removeLast()
            self.upValue.removeLast()
        }
        else{
            
            self.value.removeLast()
            self.upValue.removeLast()
        }
        
        // Access null violation fail safe
        
        if self.value.isEmpty || self.value == "0"{
            self.value = "0"
        }
        if self.upValue.isEmpty || self.upValue ==  "0" {
            self.upValue = "0"
        }

    }
    
    func transferValue(opp: String){
        
        //self.numLock = false
        // Safe guards against multiple opperators
        if self.upValue.contains("+") || self.upValue.contains("−") || self.upValue.contains("×") || self.upValue.contains("÷") {equal()}

        if self.upValue == "0"{
            self.upValue = "\(self.value)\(opp)"
            calc.num1 = Float(self.value) ?? 0
            self.currOpp = opp
            self.value = "0"
        }
        else if opps.contains(String(self.upValue.suffix(1))){
            self.upValue.removeLast()
            self.upValue.append(opp)
            self.currOpp = opp
        }
        else{
            calc.num1 = Float(self.upValue) ?? 0
            self.upValue.append(opp)
            self.currOpp = opp
        }
        
    }
    
    func checkIfIsInt(num:Float)->Bool{
        if num == floor(num){return true}
        else {return false}
    }
    func displayNum(){
        if checkIfIsInt(num: calc.result){
            self.upValue = String(Int(calc.result))
        }
        else{
            self.upValue = String(calc.result)
        }
    }
        
    func equal(){
        
        if self.value == "Error" {self.value = "0"}
        //else if self.value == "0" && self.upValue != "0"{return}
        calc.num2 = Float(self.value) ?? 0
        self.value = "0"
        
        
        switch self.currOpp{
        case "+":
            calc.add()
            displayNum()
            calc.clear()
            self.currOpp = ""
            break
        case "−":
            calc.substract()
            displayNum()
            calc.clear()
            self.currOpp = ""
            break
        case "×":
            calc.multiply()
            displayNum()
            calc.clear()
            self.currOpp = ""
            break
        case "÷":
            if calc.num2 == 0{
                self.value = "Error"
                self.upValue = "0"
                break
            }
            calc.divide()
            displayNum()
            calc.clear()
            self.currOpp = ""
            break
        default:
            break
        }
    }
    func buttonTaped(number: String){
            if self.value.count < 11 {

                // Safe guards against decimal point duplicates
                if self.value.contains(".") && number == "." {return}
                else if self.currOpp.isEmpty && self.upValue != "0"{
                    self.upValue = "0"
                }

                if self.value == "0" && number == "." {
                    self.value = "\(self.value)\(number)"
                }
                else if self.value == "0" || self.value == "Error"{
                    self.value = number
                }
                else{
                    self.value = "\(self.value)\(number)"
                }
                
                if self.upValue != "0" {
                    self.upValue = "\(self.upValue)\(number)"
                }
                
            }
        }
    
    func translateNumerator(num: String) -> Int{
        var number = ""
        
        num.forEach { char in
            
            switch String(char){
            case numerator.upZero.rawValue:
                
                break
            case numerator.upOne.rawValue:
                break
            case numerator.upTwo.rawValue:
                break
            case numerator.upThree.rawValue:
                break
            case numerator.upFour.rawValue:
                break
            case numerator.upFive.rawValue:
                break
            case numerator.upSix.rawValue:
                break
            case numerator.upSeven.rawValue:
                break
            case numerator.upEight.rawValue:
                break
            case numerator.upNine.rawValue:
                break
            default:
                break
            }
        }
            return Int(number) ?? 0
    }
    
    struct Calculator_view_Previews: PreviewProvider {
        
        @StateObject static var detector = MotionDetector()
        
        static var previews: some View {
            Calculator_view(detector: detector).environmentObject(detector)
        }
    }
}

class Calculator{
    var num1:Float = 0
    var fraction1numerator:Int = 0
    var fraction1denominator:Int = 0
    
    var num2:Float = 0
    var fraction2numerator:Int = 0
    var fraction2denominator:Int = 0
    
    var result:Float = 0
    
    func getDenominator(num:String){
        
    }
    
    func clear(){
        self.num1 = 0
        self.num2 = 0
    }
    func add(){
        self.result = self.num1 + self.num2
    }
    
    func multiply(){
        self.result = self.num1 * self.num2
    }
    
    func substract(){
        self.result = self.num1 - self.num2
    }

    func divide(){
        self.result = self.num1 / self.num2
    }

}
