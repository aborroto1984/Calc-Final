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

enum operators: String{
    case add       = "+"
    case plus      = "×"
    case substract = "−"
    case divide    = "÷"
    case fraction  = "_"
}

enum unit: String{
    case feet  = "'"
    case inch  = "\""
    case yard  = "yrd"
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
    
    // Main Screen Variables
    @State var upNum1 = "0"
    @State var upFractionNumerator1 = ""
    @State var upFraction1Slash = ""
    @State var upFractionDenominator1 = ""
    @State var upUnit1 = ""
    
    @State var currOp = ""
    
    @State var upNum2 = ""
    @State var upFractionNumerator2 = ""
    @State var upFraction2Slash = ""
    @State var upFractionDenominator2 = ""
    @State var upUnit2 = ""
    
    @State var num = "0"
    @State var numerator = ""
    @State var fractionSlash = ""
    @State var denominator = ""
    @State var unit = ""
    
    @State var num1HasFraction = false
    @State var num2HasFraction = false
    @State var numHasFraction = false
    
    @State var num1HasUnit = false
    @State var num2HasUnit = false
    @State var numHasUnit = false
    
    @State var numIsDecimal = false
    
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
            // Digital display
            VStack{
                // Top numbers
                HStack{
                    Spacer()
                    // Number 1
                    Text(self.upNum1)
                        .font(.system(size: 35))
                    // Number 1 Fraction
                    if num1HasFraction{
                        ZStack{
                            Text(self.upFractionNumerator1).offset(y:-13)
                            Text(self.upFraction1Slash).offset(y:-9)
                            Text(self.upFractionDenominator1).offset(y:13)
                            
                        }
                        .font(.system(size:20))}
                    // Number 1 unit
                    if num1HasUnit{Text(self.upUnit1)}
                    
                    // Operator
                    Text(self.currOp).font(.system(size:35))
                    
                    // Number 2
                    if self.upNum2 != ""{Text(self.upNum2)
                        .font(.system(size: 35))}
                    // number 2 fraction
                    if num2HasFraction{
                        ZStack{
                            Text(self.upFractionNumerator2).offset(y:-13)
                            Text(self.upFraction2Slash).offset(y:-9)
                            Text(self.upFractionDenominator2).offset(y:13)
                            
                        }
                        .font(.system(size:20))}
                    // Number 2 unit
                    if num2HasUnit{Text(self.upUnit2)}
                        
                }
                
                Spacer()
                // Bottom number
                HStack{
                    Spacer()
                    // Number
                    Text(self.num)
                        .bold()
                        .font(.system(size: 70))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    // Number fraction
                    if numHasFraction {
                        ZStack{
                            Text(self.numerator).offset(y: -20)
                            Text(self.fractionSlash).offset(y: -15)
                            Text(self.denominator).offset(y: 20)
                            
                        }
                        .bold()
                        .font(.system(size: 35))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    }
                    if numHasUnit{Text(self.unit)}
                }
                
            }
            .frame(width: .infinity)
            .padding()
            
            
            
            
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
                
                Button(action: {transferValue(op: "÷")
                }, label: {Image("divideButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver2Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "7")
                    
                }, label: {Image("sevenButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "8")
                    
                }, label: {Image("eightButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "9")
                    
                }, label: {Image("nineButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "×")
                    
                }, label: {Image("multiplyButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver4Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "4")
                    
                }, label: {Image("fourButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "5")
                    
                }, label: {Image("fiveButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "6")
                    
                }, label: {Image("sixButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "−")
                    
                }, label: {Image("minusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver8Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "1")
                    
                }, label: {Image("oneButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "2")
                    
                }, label: {Image("twoButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "3")
                    
                }, label: {Image("threeButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "+")
                    
                }, label: {Image("plusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {
                    
                }, label: {Image("xOver16Button").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "0")
                    
                }, label: {Image("zeroButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: ".")
                    
                }, label: {Image("pointButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {back()
                    
                }, label: {Image("deleteButton").resizable().scaledToFit()})
                
                Button(action: {equal()
                    
                }, label: {Image("equalButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {if !numIsDecimal{typingAFraction()}
                    
                }, label: {Image("emptyFractionButton").resizable().scaledToFit()})
                
            }
        }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
    func typingAFraction(){
//
        if self.typingaFractionState == 0{
            self.typingNumerator = true
            self.numHasFraction = true
            if self.currOp.isEmpty{
                self.num1HasFraction = true
            }else{
                self.num2HasFraction = true
            }
            self.typingaFractionState += 1
        }
        else if self.typingaFractionState == 1{
            self.typingNumerator = false
            self.typingDenominator = true
            self.typingaFractionState += 1
        }
        else{
            self.typingNumerator = false
            self.typingDenominator = false
            self.typingaFractionState = 0
            // Filling empty with zero
            if self.num1HasFraction{
                if self.upFractionNumerator1.isEmpty{
                    self.upFractionNumerator1 = "0"
                    self.numerator = "0"
                }
                else if self.upFractionDenominator1.isEmpty{
                    self.upFractionDenominator1 = "0"
                    self.denominator = "0"
                }
            }
            else if self.num2HasFraction{
                if self.upFractionNumerator2.isEmpty{
                    self.upFractionNumerator2 = "0"
                    self.numerator = "0"
                }
                else if self.upFractionDenominator2.isEmpty{
                    self.upFractionDenominator2 = "0"
                    self.denominator = "0"
                }
            }
        }
    }
    
    // Clear helper fuctions
    func clearNum(){
        if self.numHasFraction{
            self.numerator = ""
            self.denominator = ""
            self.fractionSlash = ""
            self.numHasFraction = false
        }
        self.num = "0"
    }
    func clearNum1(){
        if self.num1HasFraction{
            self.upFractionNumerator1 = ""
            self.upFractionDenominator1 = ""
            self.upFraction1Slash = ""
            self.num1HasFraction = false
        }
        self.upNum1 = "0"
    }
    func clearNum2(){
        if self.num2HasFraction{
            self.upFractionNumerator2 = ""
            self.upFractionDenominator2 = ""
            self.upFraction2Slash = ""
            self.num2HasFraction = false
        }
        self.upNum2 = ""
    }
    
    func clear(){
        // Clearing fraction members
        if self.typingNumerator{
            if self.num1HasFraction{
                self.upFractionNumerator1 = ""
                self.upFraction1Slash = ""
            }
            else if self.num2HasFraction{
                self.upFractionNumerator2 = ""
                self.upFraction2Slash = ""
            }
            self.numerator = ""
            self.fractionSlash = ""
        }
        else if self.typingDenominator{
            if self.num1HasFraction{
                self.upFractionDenominator1 = ""
                // Dynamicaly returning fraction slash to optimal size
                self.fractionSlash = ""
                self.upFraction1Slash = ""
                for _ in 1...self.numerator.count{
                    self.fractionSlash = "\(self.fractionSlash)" + "_"
                    self.upFraction1Slash = "\(self.upFraction1Slash)" + "_"}
            }
            else if self.num2HasFraction{
                self.upFractionDenominator2 = ""
                // Dynamicaly returning fraction slash to optimal size
                self.fractionSlash = ""
                self.upFraction1Slash = ""
                for _ in 1...self.numerator.count{
                    self.fractionSlash = "\(self.fractionSlash)" + "_"
                    self.upFraction2Slash = "\(self.upFraction2Slash)" + "_"}
            }
            self.denominator = ""
        }
    
        
        else if self.currOp.isEmpty == false{
            // Clearing num and num2
            clearNum()
            clearNum2()
            self.currOp = ""
        }
        
        else {
            // Clearing num and num1
            clearNum()
            clearNum1()
            
        }
    }
    
    func back(){
        if self.num2HasFraction {
            // Deleting num2 fraction
            self.upFractionNumerator2 = ""
            self.upFractionDenominator2 = ""
            self.upFraction2Slash = ""
            self.num2HasFraction = false
            // Deleting num fraction
            self.numerator = ""
            self.denominator = ""
            self.fractionSlash = ""
            self.numHasFraction = false
        }
        else if self.upNum2 != ""{
            self.upNum2.removeLast()
            self.num.removeLast()
        }
        else if !self.currOp.isEmpty{
            self.currOp = ""
            if self.num1HasFraction{
                self.numHasFraction = true
                self.numerator = self.upFractionNumerator1
                self.denominator = self.upFractionDenominator1
                self.fractionSlash = self.upFraction1Slash
            }
            self.num = self.upNum1
        }
        else if self.num1HasFraction{
            //self.currOp = ""
            // Deleting num1 fraction
            self.upFractionNumerator1 = ""
            self.upFractionDenominator1 = ""
            self.upFraction1Slash = ""
            self.num1HasFraction = false
            // Deleting num fraction
            self.numerator = ""
            self.denominator = ""
            self.fractionSlash = ""
            self.numHasFraction = false
        }else{
            //self.currOp = ""
            self.upNum1.removeLast()
            self.num.removeLast()
        }
        
        
        // Save guard if value is empty
        if self.upNum1.isEmpty || self.num.isEmpty{
            if self.num.isEmpty && !self.numHasFraction{self.num = "0"}
            if self.upNum1.isEmpty && !self.num1HasFraction{self.upNum1 = "0"}
        }

    }
    
    func transferValue(op: String){
        
        // Safe guards against multiple opperators
        if self.upValue.contains("+") || self.upValue.contains("−") || self.upValue.contains("×") || self.upValue.contains("÷") {equal()}
        else{
            self.currOp = op

            if self.num1HasFraction{
                calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
            }
            calc.num1 = Float(self.upNum1) ?? 0
            
            clearNum()
        }

    }
    
    func checkIfIsInt(num:Float)->Bool{
        if num == floor(num){return true}
        else {return false}
    }
    func displayNum(){
        if checkIfIsInt(num: calc.result){
            self.upNum1 = String(Int(calc.result))
        }
        else{
            self.upNum1 = String(calc.result)
        }
    }
        
    func equal(){
        
        if self.num == "Error" {self.num = "0"}
        //else if self.value == "0" && self.upValue != "0"{return}

        if self.num1HasFraction{
            calc.fraction2numerator = Int(self.upFractionNumerator2) ?? 0
            calc.fraction2denominator = Int(self.upFractionDenominator2) ?? 0
        }
        calc.num2 = Float(self.upNum2) ?? 0
        
        clearNum()
        clearNum2()
        
        switch self.currOp{
        case "+":
            calc.add()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        case "−":
            calc.substract()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        case "×":
            calc.multiply()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        case "÷":
            if calc.num2 == 0{
                self.value = "Error"
                self.upNum1 = "0"
                break
            }
            calc.divide()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        default:
            break
        }
    }
    func buttonTaped(number: String){
        // If num contains decimal fractions are not allowed
        if number == "."{
            self.numIsDecimal = true
        }
        // Typing num1 fraction
        if self.numHasFraction && self.currOp.isEmpty{
            // If the number is a decimal no fractions are allowed
            if self.num.contains(".") {
                self.numHasFraction = false
                self.num1HasFraction = false
                return}
            
            else if self.typingNumerator && number != "."{
                // Getting rid of the zero if it is just fraction
                if self.num == "0"{
                    self.num = ""
                    self.upNum1 = ""
                }
                self.numerator = "\(self.numerator)\(number)"
                self.upFractionNumerator1 = "\(self.upFractionNumerator1)\(number)"
                self.fractionSlash = "\(self.fractionSlash)" + "_"
                self.upFraction1Slash = "\(self.upFraction1Slash)" + "_"
            }
            else if self.typingDenominator && number != "."{
                self.denominator = "\(self.denominator)\(number)"
                self.upFractionDenominator1 = "\(self.upFractionDenominator1)\(number)"
                if self.denominator.count > self.numerator.count{
                    self.fractionSlash = "\(self.fractionSlash)" + "_"
                    self.upFraction1Slash = "\(self.upFraction1Slash)" + "_"
                }
            
            }
        }
        // Typing num2 fraction
        else if self.num2HasFraction{
            // If the number is a decimal no fractions are allowed
            if self.num.contains(".") {
                self.numHasFraction = false
                self.num2HasFraction = false
                return}
            
            else if self.typingNumerator && number != "."{
                // Getting rid of the zero if it is just fraction
                if self.num == "0"{
                    self.num = ""
                    self.upNum2 = ""
                }
                self.numerator = "\(self.numerator)\(number)"
                self.upFractionNumerator2 = "\(self.upFractionNumerator2)\(number)"
                self.fractionSlash = "\(self.fractionSlash)" + "_"
                self.upFraction2Slash = "\(self.upFraction2Slash)" + "_"
            }
            else if self.typingDenominator && number != "."{
                self.denominator = "\(self.denominator)\(number)"
                self.upFractionDenominator2 = "\(self.upFractionDenominator2)\(number)"
                if self.denominator.count > self.numerator.count{
                    self.fractionSlash = "\(self.fractionSlash)" + "_"
                    self.upFraction2Slash = "\(self.upFraction2Slash)" + "_"
                }
            }
        }
        // Typing regular numbers
        else if self.currOp.isEmpty{
            // Adds zero if decimal point is taped
            if number == "." && self.num == "0"{
                self.num = "0."
                self.upNum1 = "0."
            }
            // Safe guards against decimal point duplicates
            if self.num.contains(".") && number == "." {return}
            
            if self.num == "0" || self.num == "Error"{
                self.num = number
                self.upNum1 = number
            }
            else{
                self.num = "\(self.num)\(number)"
                self.upNum1 = "\(self.upNum1)\(number)"
            }
        }
        
        else if self.currOp.isEmpty == false{
            // Adds zero if decimal point is taped
            if number == "." && self.num == "0"{
                self.num = "0."
                self.upNum2 = "0."
            }
            // Safe guards against decimal point duplicates
            if self.num.contains(".") && number == "." {return}
            
            if self.num == "0" || self.num == "Error"{
                self.num = number
                self.upNum2 = number
            }
            else{
                self.num = "\(self.num)\(number)"
                self.upNum2 = "\(self.upNum2)\(number)"
            }
        }
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
