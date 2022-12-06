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
    @State var denominator1WasPressed = false
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
    
    func copyNumToNum1(){
        self.upNum1 = self.num
        if numHasFraction{
            self.upFractionNumerator1 = self.numerator
            self.upFraction1Slash     = self.fractionSlash
            self.upFractionDenominator1 = self.denominator
        }
        if numHasUnit{
            self.upUnit1 = self.unit
        }
    }
    func copyNumToNum2(){
        self.upNum2 = self.num
        if numHasFraction{
            self.upFractionNumerator2 = self.numerator
            self.upFraction2Slash     = self.fractionSlash
            self.upFractionDenominator2 = self.denominator
        }
        if numHasUnit{
            self.upUnit2 = self.unit
        }
    }
    
    func typingAFraction(){

        if self.typingaFractionState == 0{
            self.typingNumerator = true
            self.numHasFraction = true
            
            if self.currOp.isEmpty{
                self.num1HasFraction = true
            }else{
                self.num2HasFraction = true
            }
            self.typingaFractionState = 1
            
            // Initial numerator state
            if self.numerator == ""{
                self.numerator = "0"
                self.fractionSlash = "_"
                if self.currOp == ""{
                    copyNumToNum1()
                }else{
                    copyNumToNum2()
                }
            }

            // Leaving just fraction if num = 0
            if self.num == "0"{
                self.num = ""
                self.numerator = "0"
                self.fractionSlash = "_"
                
                if self.num2HasFraction{
                    copyNumToNum2()}
                else {copyNumToNum1()}
                    
            }
        }
        else if self.typingaFractionState == 1{
            // Initial denominator state
            self.denominator = "1"
            self.typingNumerator = false
            self.typingDenominator = true
            self.typingaFractionState = 2
            if self.num2HasFraction{
                copyNumToNum2()
            }else{
                copyNumToNum1()
            }
        }
        else if self.typingaFractionState == 2{
            self.typingNumerator = false
            self.typingDenominator = false
            self.typingaFractionState = 0
            
            
            
            
            // Filling empty with zero
//            if self.num1HasFraction{
//                if self.upFractionNumerator1.isEmpty{
//                    self.upFractionNumerator1 = "0"
//                    self.numerator = "0"
//                }
//                else if self.upFractionDenominator1.isEmpty{
//                    self.upFractionDenominator1 = "0"
//                    self.denominator = "0"
//                }
//            }
//            else if self.num2HasFraction{
//                if self.upFractionNumerator2.isEmpty{
//                    self.upFractionNumerator2 = "0"
//                    self.numerator = "0"
//                }
//                else if self.upFractionDenominator2.isEmpty{
//                    self.upFractionDenominator2 = "0"
//                    self.denominator = "0"
//                }
//            }
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
            
            if self.numerator == "0"{
                self.typingNumerator = false
                self.numHasFraction = false
                
                if self.num2HasFraction{
                    self.num2HasFraction = false
                }
                else{
                    self.num1HasFraction = false}
                
                self.typingaFractionState = 0
                if self.num == ""{ self.num = "0"}
            }
            
            self.numerator = "0"
            self.fractionSlash = "_"
            
            if self.currOp == ""{
                copyNumToNum1()
            }
            else{
                copyNumToNum2()}
        }
        
        else if self.typingDenominator{
            
            if self.denominator == "1"{
                self.typingDenominator = false
                self.typingNumerator = true
                self.denominator = ""
                self.typingaFractionState = 1
            }else{
                self.denominator = "1"
                self.fractionSlash = ""
                for _ in 1...self.numerator.count{
                    self.fractionSlash = "\(self.fractionSlash)" + "_"}}
            
            if self.num2HasFraction{
                copyNumToNum2()}
            else{copyNumToNum1()}
        }
        
        else if self.currOp == ""{
            // Clearing num and num2
            clearNum()
            clearNum1()
        }
        else if self.num2HasFraction{
            clearNum()
            clearNum2()
        }
        else if self.upNum2 == ""{
            self.currOp = ""
        }
        else {
            // Clearing num and num1
            clearNum()
            clearNum2()
            
        }
    }
    
    func back(){
        // Deleting numbers while writing a fraction
        if typingNumerator{
            self.numerator.removeLast()
            self.fractionSlash.removeLast()
            
            if self.numerator.isEmpty{
                self.numerator = "0"
                self.fractionSlash = "_"
            }
            
            if self.num2HasFraction{
                copyNumToNum2()
            }else{
                copyNumToNum1()}
        }
        else if typingDenominator{
            self.denominator.removeLast()
            if self.denominator.count >= numerator.count{
                self.fractionSlash.removeLast()
            }
            if self.denominator.isEmpty{
                self.denominator = "1"
            }
            
            if self.num2HasFraction{
                copyNumToNum2()
            }else{
                copyNumToNum1()}
        }
        else if self.num2HasFraction {
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
//        if self.numerator.isEmpty{
//            self.numerator = "0"
//        }else if self.denominator.isEmpty{
//            self.denominator = "0"
//        }
//
//        if self.num2HasFraction{
//            copyNumToNum2()
//        }else{
//            copyNumToNum1()}
    }
    
    func transferValue(op: String){
        
        // Safe guards against multiple opperators
        if self.currOp != "" {
            return
        }
        else{
            self.currOp = op

            if self.num1HasFraction{
                calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
            }
            calc.num1 = Float(self.upNum1) ?? 0
            
            clearNum()
            
            self.numIsDecimal = false
        }

    }
    
    // Equal helper functions
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
    func displayFraction(){
        self.upFractionNumerator1 = String(calc.resultNumerator)
        self.upFractionDenominator1 = String(calc.resultDenominator)
        
        if self.upFractionNumerator1 == "0"{
            // Hides result fraction if no fration
            self.num1HasFraction = false
        }else {
            self.num1HasFraction = true
            var size = 0
            if self.upFractionNumerator1.count >= self.upFractionDenominator1.count {
                size = self.upFractionNumerator1.count
            }else {
                size = self.upFractionDenominator1.count
            }
            for _ in 1...size{
                self.upFraction1Slash = "\(self.upFraction1Slash)" + "_"}
            
        }
    }
        
    func equal(){
        
        if self.num == "Error" {self.num = "0"}

        if self.num2HasFraction{
            calc.fraction2numerator = Int(self.upFractionNumerator2) ?? 0
            calc.fraction2denominator = Int(self.upFractionDenominator2) ?? 0
        }
        if self.upNum2 == "" {self.upNum2 = "0"}
        calc.num2 = Float(self.upNum2) ?? 0
        
        
        switch self.currOp{
        case "+":
            calc.add()
            displayNum()
            displayFraction()
            calc.clear()
            self.currOp = ""
            break
        case "−":
            calc.substract()
            displayNum()
            displayFraction()
            calc.clear()
            self.currOp = ""
            break
        case "×":
            calc.multiply()
            displayNum()
            displayFraction()
            calc.clear()
            self.currOp = ""
            break
        case "÷":
            if self.upNum2 == "0" && !self.num2HasFraction{
                self.num = "Error"
                self.upNum1 = "0"
                self.currOp = ""
                clearNum2()
                return
            }else{
                calc.divide()
                displayNum()
                displayFraction()
                calc.clear()
                self.currOp = ""}
            break
        default:
            break
        }
        
        clearNum()
        clearNum2()
    }
    func buttonTaped(number: String){
        // Marking current number a decimal
        if self.num.contains("."){self.numIsDecimal = true}else{self.numIsDecimal = false}
        
        if typingNumerator && !self.numIsDecimal{
            // Removing the zero
            if self.numerator == "0" {
                self.numerator = ""
                self.fractionSlash = ""
            }
            // Typing numerator
            self.numerator = "\(self.numerator)\(number)"
            self.fractionSlash = "\(self.fractionSlash)" + "_"
        }
        
        else if self.typingDenominator && !self.numIsDecimal{
            // Removing one
            if self.denominator == "1"{
                self.denominator = ""
            }
            // Typing denominator
            if denominator1WasPressed{
                self.denominator = "1" + "\(number)"
                denominator1WasPressed = false
            }else{
                self.denominator = "\(self.denominator)\(number)"
            }
            
            if self.denominator.count > numerator.count {
                self.fractionSlash = "\(self.fractionSlash)" + "_"
            }
            // Typing a one in the denominator
            if number == "1" && self.denominator == "1"{
                denominator1WasPressed = true
            }
        }
        
        else if number == "." && self.num == "0"{
            self.num = "\(self.num)\(number)"
        }
        else if self.num == "0" || self.num == "Error"{
            self.num = ""
            self.num = "\(self.num)\(number)"
            // cleaning fraction if result had any
            if self.currOp == ""{
                self.num1HasFraction = false
                self.upFractionNumerator1 = ""
                self.upFraction1Slash = ""
                self.upFractionDenominator1 = ""
            }
        }
        else{
            self.num = "\(self.num)\(number)"
        }
        
        // Copying the num to the top views
        if self.currOp.isEmpty{
            copyNumToNum1()
        }else{
            copyNumToNum2()
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
    var resultNumerator: Int = 0
    var resultDenominator: Int = 0
    
    var gcd = 0
    
    // Greater common denomintor
    func gcd(num1: Int, num2: Int) -> Int {
        if num2 == 0{return num1}
        else {return gcd(num1:num2, num2:num1 % num2)}
    }
    
    // Improper fraction builder
    func mixToFraction(){
        if num1 != 0 && fraction1numerator != 0{
            fraction1numerator = (fraction1denominator * Int(num1)) + fraction1numerator
            num1 = 0
        }else if num2 != 0 && fraction2numerator != 0{
            fraction2numerator = (fraction2denominator * Int(num2)) + fraction2numerator
            num2 = 0
        }
    }
    
    // int into fraction converter
    func intToFraction(){

        if fraction2numerator == 0  && fraction2denominator == 0{
            
            if num2 == floor(num2){
                fraction2numerator = Int(num2)
                fraction2denominator = 1
                num2 = 0
            }
            // Working on operation between decimals and fractions
//            else{
//                var count = 0
//                var num2Str = String(num2)
//                for {
//                    num2 = num2 * 10
//                    count += 1
//                }
//
//                fraction2numerator = Int(num2)
//            }
//             // needs to change to allow decimal operations with fractions
//

        }
        else if fraction1numerator == 0  && fraction1denominator == 0{
            fraction1numerator = Int(num1) // needs to change to allow decimal operations with fractions
            fraction1denominator = 1
            num1 = 0
        }
        // Accounting for fractions with a 0 numerator
        else if fraction2numerator == 0  && fraction2denominator != 0{
            fraction2numerator = 0
            fraction2denominator = 0
            intToFraction()
        }
        else if fraction1numerator == 0  && fraction1denominator != 0{
            fraction1numerator = 0
            fraction1denominator = 0
            intToFraction()
        }
    }
    
    // Simplifying result
    func fractionSimplifier(){
        gcd = gcd(num1: resultNumerator, num2: resultDenominator)
        if gcd != 0{
            resultNumerator = resultNumerator / gcd
            resultDenominator = resultDenominator / gcd}
        
        if resultNumerator > resultDenominator{
            result += Float(resultNumerator / resultDenominator)
            resultNumerator = resultNumerator % resultDenominator
        }
    }
    
    func correctingResult(){
        if resultDenominator == 1{
            result = result + Float(resultNumerator)
            resultNumerator = 0
            resultDenominator = 0
        }
    }
    
    func clear(){
        self.num1 = 0
        self.num2 = 0
        self.fraction1numerator = 0
        self.fraction1denominator = 0
        self.fraction2numerator = 0
        self.fraction2denominator = 0
        self.result = 0
        self.resultNumerator = 0
        self.resultDenominator = 0
    }
    func add(){
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            result = num1 + num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Calculating numerator
            resultNumerator = ((fraction1numerator * fraction2denominator) + (fraction2numerator * fraction1denominator))
            // Calculating denominaor
            resultDenominator = fraction1denominator * fraction2denominator
            // Simplifying fraction
            fractionSimplifier()
            // Making sure fraction it is still a fraction
            correctingResult()
        }
    }
    
    func multiply(){
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            self.result = self.num1 * self.num2}
        
        else{
            // Multipliying fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Multiplying
            resultNumerator = fraction1numerator * fraction2numerator
            resultDenominator = fraction1denominator * fraction2denominator
            // Simplifying fraction
            fractionSimplifier()
            // Making sure fraction it is still a fraction
            correctingResult()
        }
    }
    
    func substract(){
        
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            result = num1 - num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Calculating numerator
            resultNumerator = ((fraction1numerator * fraction2denominator) - (fraction2numerator * fraction1denominator))
            // Calculating denominaor
            resultDenominator = fraction1denominator * fraction2denominator
            // Simplifying fraction
            fractionSimplifier()
            // Making sure fraction it is still a fraction
            correctingResult()
        }
    }

    func divide(){
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            if num2 != 0{
                result = self.num1 / self.num2}
        }
        
        else{
            // Dividing fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Multiplying
            resultNumerator = fraction1numerator * fraction2denominator
            resultDenominator = fraction1denominator * fraction2numerator
            // Simplifying fraction
            fractionSimplifier()
            // Making sure fraction it is still a fraction
            correctingResult()
        }
    }

}
