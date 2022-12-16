//
//  Calculator view.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/23/22.
//

import SwiftUI

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

    @State var numIsNegative = false
    @State var fractionIsNegative = false
    @State var num1IsNegative = false
    @State var num1FractionIsNegative = false
    @State var num2IsNegative = false
    @State var num2FractionIsNegative = false

    @State var num1IsSquare = false
    @State var num2IsSquare = false
    @State var numIsSquare = false

    @State var fractionButtonImage = "emptyFractionButton"
    
    @State var copyNum = ""
    @State var copyNumerator = ""
    @State var copyDenominator = ""
    @State var copyFractionSlash = ""
    @State var copyIsNumNegative = false
    @State var copyNumHasFraction = false
    @State var copyIsFractionNegative = false
    @State var copyNumIsSquare = false
    @State var numberStoredText = ""
    
    // Aligments test
//    @State var upNum1 = "-36"
//    @State var upFractionNumerator1 = "10"
//    @State var upFraction1Slash = "__"
//    @State var upFractionDenominator1 = "3"
//    @State var upUnit1 = ""
//
//    @State var currOp = "+"
//
//    @State var upNum2 = "-46"
//    @State var upFractionNumerator2 = "14"
//    @State var upFraction2Slash = "___"
//    @State var upFractionDenominator2 = "10"
//    @State var upUnit2 = ""
//
//    @State var num = "400"
//    @State var numerator = "234"
//    @State var fractionSlash = "___"
//    @State var denominator = "35"
//    @State var unit = ""
//
//    @State var num1HasFraction = true
//    @State var num2HasFraction = true
//    @State var numHasFraction = true
//
//    @State var num1HasUnit = false
//    @State var num2HasUnit = false
//    @State var numHasUnit = false
//
//    @State var numIsDecimal = false
//
//    @State var numIsNegative = true
//    @State var fractionIsNegative = false
//    @State var num1IsNegative = true
//    @State var num1FractionIsNegative = false
//    @State var num2IsNegative = true
//    @State var num2FractionIsNegative = false
//
//    @State var num1IsSquare = true
//    @State var num2IsSquare = true
//    @State var numIsSquare = true
    
    var body: some View {
        
        VStack{
            
            ZStack{
                
//                HStack{
//                    Image("menu").padding(.leading)
//                    Spacer()
//
//                }
                
                Text("Calculator")
                
                    .font(.largeTitle).foregroundColor(.black)
            }
            // Digital display
            VStack{
                // Top numbers
                HStack{
                    Spacer()
// Number 1--------------------------------------------------------------------------
                    num1View
// Number 2--------------------------------------------------------------------------
                    num2View
                }
                
                Spacer()
// Bottom number----------------------------------------------------------------------
                numView
                HStack{
                    Text(self.numberStoredText).frame(height:1)
                    Spacer()
                }
            }
            .frame(width: .infinity)
            .padding()
            
            
            HStack{
                Button(action: {clear()
                    
                }, label: {Image("clearButton").resizable().scaledToFit()})
                
                Button(action: {clearAll()
                    
                }, label: {Image("clearAllButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {transferValue(op: "% of")
                    
                }, label: {Image("percentButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {transferValue(op: "÷")
                }, label: {Image("divideButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {paste()
                    
                }, label: {Image("pasteBigButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
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
                
                Button(action: {copy()
                    
                }, label: {Image("copyBigButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
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
                
                Button(action: {squared()
                    
                }, label: {Image("squareButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
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
                
                Button(action: {plusMinus()
                    
                }, label: {Image("plusMinusBigButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
            }
            
            HStack{
                Button(action: {buttonTaped(number: "0")
                    
                }, label: {Image("zeroButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: ".")
                    
                }, label: {Image("pointButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                Button(action: {back()
                    
                }, label: {Image("deleteButton").resizable().scaledToFit()})
                
                
                Button(action: {if !numIsDecimal{typingAFraction()}
                    
                }, label: {Image( self.fractionButtonImage
                ).resizable().scaledToFit()})
                
                Button(action: {equal()
                    
                }, label: {Image("equalButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator ? 0 : 1)
                
                
                
            }
        }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
    // Views-------------------------------------------------------------------------
    
    var num1View: some View{
        Group{
            if num1IsSquare && num1HasFraction{ Text("(").font(.system(size: 35))}
            Text(self.upNum1)
                .font(.system(size: 35))
                .lineLimit(1)
            
            
            // Number 1 Fraction
            if num1HasFraction{
                HStack{
                    // Number 1 Fraction is negative
                    if num1FractionIsNegative{ Text("-")}
                    ZStack{
                        Text(self.upFractionNumerator1).offset(y:-15)
                        Text(self.upFraction1Slash).offset(y:-9)
                        Text(self.upFractionDenominator1).offset(y:18)
                    }
                }.font(.system(size:25))
                    .lineLimit(1)
                
            }
            // Number 1 unit or is squared
            if num1IsSquare && num1HasFraction{ Text(")").font(.system(size: 35))}
            if num1IsSquare{Text("²").font(.system(size: 35)).offset(x:-5, y: -10)}
            if num1HasUnit{Text(self.upUnit1)}
            
            // Operator
            Text(self.currOp).font(.system(size:30))
                .lineLimit(1)
        }
    }
    
    var num2View: some View{
        Group{
            // If number is negative
            if self.num2IsNegative || self.num2IsSquare || self.num2FractionIsNegative{ Text("(").font(.system(size: 35)) }
            
            if self.upNum2 != ""{
                Group{
                    
                    
                    Text(self.upNum2)
                    
                    
                    // If number is negative
                    //if self.num2IsNegative && !self.num2HasFraction{ Text(")") }
                    
                }.font(.system(size: 35))
                    .lineLimit(1)
                    
            }
            
            // number 2 fraction
            if num2HasFraction{
                HStack{
                    // Number 2 Fraction is negative
                    if num2FractionIsNegative{
                            Text("-").font(.system(size: 25))
                    }
                    
                    ZStack{
                        Text(self.upFractionNumerator2).offset(y:-15)
                        Text(self.upFraction2Slash).offset(y:-9)
                        Text(self.upFractionDenominator2).offset(y:18)
                    }.font(.system(size:25))
                        .lineLimit(1)
                }
                    
            }
            // Number 2 Fraction is negative
            if self.num2FractionIsNegative || self.num2IsNegative || self.num2IsSquare{ Text(")").font(.system(size: 35))}
            
            // Number 2 unit or is squared
            if num2IsSquare{Text("²").font(.system(size: 35)).offset(x:-5, y: -10)}
            if num2HasUnit{Text(self.upUnit2)}
        }
    }
    
    var numView: some View{
        Group{
            HStack{
                if self.num.count < 8 {Spacer()}
                
                if self.numIsSquare && self.numHasFraction{ Text("(").font(.system(size: 70))}
                // Number
                Text(self.num)
                    
                    .font(.system(size: 70))
                    .lineLimit(1)
                // Number fraction
                if numHasFraction {
                    HStack{
                        // Number Fraction is negative
                        if fractionIsNegative{ Text("-")}
                        
                        ZStack{
                            Text(self.numerator).offset(y: -20)
                            Text(self.fractionSlash).offset(y: -15)
                            Text(self.denominator).offset(y: 20)
                        }
                    }
                        .font(.system(size: 35))
                        .bold()
                        .lineLimit(1)
                }
                if self.numIsSquare && self.numHasFraction{ Text(")").font(.system(size: 70))}
                if numIsSquare{Text("²").font(.system(size: 70)).offset(x:-5, y: -10)}
                if numHasUnit{Text(self.unit)}
            }
        }
    }
    // Functions---------------------------------------------------------------------
    func noNumber()->Bool{
        if self.num == "0" && !self.numHasFraction{
            return true
        }else{
            return false
        }
    }
    func noNum1()->Bool{
        if self.upNum1 == "0" && !self.num1HasFraction{
            return true
        }else{
            return false
        }
    }
    func noNum2()->Bool{
        if self.upNum2 == "" && !self.num2HasFraction{
            return true
        }else{
            return false
        }
    }
    
    func fractionButtonImageUpdater(){
        // Updating button image according to state
        if self.typingNumerator{
            self.fractionButtonImage = "denominatorButton"
        }
        else if self.typingDenominator{
            self.fractionButtonImage = "exitButton"
        }
        else{
            self.fractionButtonImage = "emptyFractionButton"
        }
    }
    
    func squared(){
        // Typing firt number
        if self.currOp == ""{
            self.num1IsSquare = !self.num1IsSquare
        }else{
            self.num2IsSquare = !self.num2IsSquare
        }
        self.numIsSquare = !self.numIsSquare
    }
    
    func copy(){
        
        if noNum2(){
            self.copyNum = self.upNum1
            self.copyNumerator = self.upFractionNumerator1
            self.copyDenominator = self.upFractionDenominator1
            self.copyFractionSlash = self.upFraction1Slash
            self.copyIsNumNegative = self.num1IsNegative
            self.copyIsFractionNegative = self.num1FractionIsNegative
            self.copyNumHasFraction = self.num1HasFraction
            self.copyNumIsSquare = self.num1IsSquare
            self.numberStoredText = "number stored"
        }
        else if noNumber() && !noNum1() || !noNum1() && !noNum2(){
            self.copyNum = self.num
            self.copyNumerator = self.numerator
            self.copyDenominator = self.denominator
            self.copyFractionSlash = self.fractionSlash
            self.copyIsNumNegative = self.numIsNegative
            self.copyIsFractionNegative = self.fractionIsNegative
            self.copyNumHasFraction = self.numHasFraction
            self.copyNumIsSquare = self.numIsSquare
            self.numberStoredText = "number stored"
        }
    }
    func paste(){
        if self.numberStoredText != ""{
            if self.currOp == ""{
                self.upNum1 = self.copyNum
                self.upFractionNumerator1 = self.copyNumerator
                self.upFractionDenominator1 = self.copyDenominator
                self.upFraction1Slash = self.copyFractionSlash
                self.num1IsNegative = self.copyIsNumNegative
                self.num1FractionIsNegative = self.copyIsFractionNegative
                self.num1HasFraction = self.copyNumHasFraction
                self.num1IsSquare = self.copyNumIsSquare
                self.numberStoredText = ""
            }
            else{
                self.upNum2 = self.copyNum
                self.upFractionNumerator2 = self.copyNumerator
                self.upFractionDenominator2 = self.copyDenominator
                self.upFraction2Slash = self.copyFractionSlash
                self.num2IsNegative = self.copyIsNumNegative
                self.num2FractionIsNegative = self.copyIsFractionNegative
                self.num2HasFraction = self.copyNumHasFraction
                self.num2IsSquare = self.copyNumIsSquare
                self.numberStoredText = ""
            }
            // Clearing memory
            self.copyNum = ""
            self.copyNumerator = ""
            self.copyDenominator = ""
            self.copyFractionSlash = ""
            self.copyIsNumNegative = false
            self.copyIsFractionNegative = false
            self.copyNumHasFraction = false
            self.copyNumIsSquare = false
        }
    }
    func plusMinus(){
        // Typing firt number
        if self.currOp == ""{
            // Number has fraction but not whole number
            if numHasFraction && num == ""{
                // Turning negative signal off and on
                self.fractionIsNegative = !self.fractionIsNegative
                self.num1FractionIsNegative = !self.num1FractionIsNegative
            }
            // Number has no fraction or a fraction with number
            else{
                // Turning negative signal off and on
                self.numIsNegative = !self.numIsNegative
                self.num1IsNegative = !self.num1IsNegative
                
                if self.numIsNegative{
                    self.num = "-" + self.num
                    self.upNum1 = "-" + self.upNum1
                }else{
                    self.num.removeFirst()
                    self.upNum1.removeFirst()
                }
            }
            // Typing second number
        }else{
            if numHasFraction && num == ""{
                // Turning negative signal off and on
                self.fractionIsNegative = !self.fractionIsNegative
                self.num2FractionIsNegative = !self.num2FractionIsNegative
            }
            // Number has no fraction or a fraction with number
            else{
                // Turning negative signal off and on
                self.numIsNegative = !self.numIsNegative
                self.num2IsNegative = !self.num2IsNegative
                
                if self.numIsNegative{
                    self.num = "-" + self.num
                    self.upNum2 = "-" + self.upNum2
                }else{
                    self.num.removeFirst()
                    self.upNum2.removeFirst()
                }
            }
        }
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
        }
        
        fractionButtonImageUpdater()
    }
    
    // Clear helper fuctions
    func clearNum(){
        if self.numHasFraction{
            self.numerator = ""
            self.denominator = ""
            self.fractionSlash = ""
            self.numHasFraction = false
            self.fractionIsNegative = false
        }
        self.numIsNegative = false
        self.numIsSquare = false
        self.num = "0"
    }
    func clearNum1(){
        if self.num1HasFraction{
            self.upFractionNumerator1 = ""
            self.upFractionDenominator1 = ""
            self.upFraction1Slash = ""
            self.num1HasFraction = false
            self.num1FractionIsNegative = false
        }
        self.num1IsNegative = false
        self.num1IsSquare = false
        self.upNum1 = "0"
    }
    func clearNum2(){
        if self.num2HasFraction{
            self.upFractionNumerator2 = ""
            self.upFractionDenominator2 = ""
            self.upFraction2Slash = ""
            self.num2HasFraction = false
            self.num2FractionIsNegative = false
        }
        self.num2IsSquare = false
        self.num2IsNegative = false
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
                fractionButtonImageUpdater()
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
            
            fractionButtonImageUpdater()
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
    func clearAll(){
        clearNum()
        clearNum1()
        clearNum2()
        self.currOp = ""
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
        if self.upNum1 == "-" || self.num == "-"{
            self.upNum1 = "0"
            self.num = "0"
        }
        
        // Save guard if value is empty
        if self.upNum1.isEmpty || self.num.isEmpty{
            if self.num.isEmpty && !self.numHasFraction{self.num = "0"}
            if self.upNum1.isEmpty && !self.num1HasFraction{self.upNum1 = "0"}
        }
    }
    
    func decimalPointLocator(number:String)-> Float{
        var pastDecimal = false
        var result: Float = 1
        
        for letter in number{
            
            if pastDecimal{
                result *= 10
            }
            
            if letter == "."{
                pastDecimal = true
            }
        }
        return result
    }
    
    func transferValue(op: String){
        
        // Safe guards against multiple opperators
        if self.currOp != "" {
            return
        }
        else{
            self.currOp = op

            // intuping the fraction
            if self.num1HasFraction{
                if self.num1FractionIsNegative{
                    calc.fraction1numerator = Int("-" + self.upFractionNumerator1) ?? 0
                    calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
                }else{
                    calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                    calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
                }
            }
            
            // calculating decimal point location
            if self.upNum1.contains("."){
                calc.num1DecimalMultiplier = decimalPointLocator(number: self.upNum1)
            }
            
            calc.num1 = Double(self.upNum1) ?? 0
            calc.num1IsSquare = self.num1IsSquare
            
            clearNum()
            
            self.numIsDecimal = false
        }

    }
    
    // Equal helper functions
    func checkIfIsInt(num:Double)->Bool{
        if num == floor(num){return true}
        else {return false}
    }
    func displayNum(){
        if checkIfIsInt(num: calc.result){
            self.upNum1 = String(Int(calc.result))
        }
        else{
            self.upNum1 = String(round(calc.result * 10000) / 10000.0)
        }
        if num1HasFraction && self.upNum1 == "0"{
            self.upNum1 = ""
        }
    }
    func displayFraction(){
        self.upFractionNumerator1 = String(calc.resultNumerator)
        self.upFractionDenominator1 = String(calc.resultDenominator)
        self.upFraction1Slash = ""
        
        if self.upFractionNumerator1 == "0"{
            // Hides result fraction if no fration
            self.num1HasFraction = false
        }else {
            self.num1HasFraction = true
            
            //Settting up the correct sign for the result
            if (self.upFractionNumerator1.contains("-") && self.upFractionDenominator1.contains("-")) || (!self.upFractionNumerator1.contains("-") && !self.upFractionDenominator1.contains("-")) {
                
                num1FractionIsNegative = false
                
                if self.upFractionNumerator1.contains("-"){
                    self.upFractionNumerator1.removeFirst()
                }
                if self.upFractionDenominator1.contains("-"){
                    self.upFractionDenominator1.removeFirst()
                }
                
            }else {
                
                num1FractionIsNegative = true
                
                if self.upFractionNumerator1.contains("-"){
                    self.upFractionNumerator1.removeFirst()
                }
                if self.upFractionDenominator1.contains("-"){
                    self.upFractionDenominator1.removeFirst()
                }
            }
                
            
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
        // Converting result from decimal to fraction
        if self.currOp == "" && !self.num1IsSquare{
            // inputing the fraction
            if self.num1HasFraction{
                calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
            }
            // inputing number
            calc.num1 = Double(self.upNum1) ?? 0
            
            // calculating decimal point location
            if self.upNum1.contains("."){
                calc.num1DecimalMultiplier = decimalPointLocator(number: self.upNum1)
            }
            
            calc.resultConverter()
            displayFraction()
            displayNum()
            calc.clear()
        }
        
        // Calculating the square of a number
        if self.currOp == "" && self.num1IsSquare{
            // inputing the fraction
            if self.num1HasFraction{
                calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
            }
            // inputing number
            calc.num1 = Double(self.upNum1) ?? 0
            calc.num1IsSquare = self.num1IsSquare
            
            
            calc.resultConverter()
            displayFraction()
            displayNum()
            calc.clear()
        }
            
        // Clearing Error
        if self.num == "Error" {self.num = "0"}

        // Imputing fraction
        if self.num2HasFraction{
            if self.num2FractionIsNegative{
                calc.fraction2numerator = Int("-" + self.upFractionNumerator2) ?? 0
                calc.fraction2denominator = Int(self.upFractionDenominator2) ?? 0
            }else{
                calc.fraction2numerator = Int(self.upFractionNumerator2) ?? 0
                calc.fraction2denominator = Int(self.upFractionDenominator2) ?? 0
            }
        }
        
        // calculating decimal point location
        if self.upNum2.contains("."){
            calc.num2DecimalMultiplier = decimalPointLocator(number: self.upNum2)
        }
        
        if self.upNum2 == "" {self.upNum2 = "0"}
        calc.num2 = Double(self.upNum2) ?? 0
        calc.num2IsSquare = self.num2IsSquare
        
        
        switch self.currOp{
        case "+":
            calc.add()
            displayFraction()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        case "−":
            calc.substract()
            displayFraction()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        case "×":
            calc.multiply()
            displayFraction()
            displayNum()
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
                displayFraction()
                displayNum()
                calc.clear()
                self.currOp = ""}
            break
        case "% of":
            calc.porcentOf()
            displayFraction()
            displayNum()
            calc.clear()
            self.currOp = ""
            break
        default:
            break
        }
        
        clearNum()
        clearNum2()
        self.num1IsSquare = false
        
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
                if self.num == "-0"{
                    self.num = "-"
                }
                if self.num.count < 9 && !self.numHasFraction{
                    self.num = "\(self.num)\(number)"
                }
            }
            
            // Copying the num to the top views
            if self.currOp.isEmpty{
                copyNumToNum1()
            }else{
                copyNumToNum2()
            }
        }
    }
    
    struct Calculator_view_Previews: PreviewProvider {
        
        @StateObject static var detector = MotionDetector()
        
        static var previews: some View {
            Calculator_view(detector: detector).environmentObject(detector)
        }
    
}

class Calculator{
    var num1:Double = 0
    var fraction1numerator:Int = 0
    var fraction1denominator:Int = 0
    var num1DecimalMultiplier:Float = 0
    var num1IsSquare = false
    
    var num2:Double = 0
    var fraction2numerator:Int = 0
    var fraction2denominator:Int = 0
    var num2DecimalMultiplier:Float = 0
    var num2IsSquare = false
    
    var result:Double = 0
    var resultNumerator: Int = 0
    var resultDenominator: Int = 0
    
    var gcd = 0
    
    // Squaring Number NOTE: Does not work on mixed numbers
    func squareNumbers(){
        // Squaring num1
        if num1IsSquare && fraction1numerator != 0 && fraction1denominator != 0 && num1 == 0{
            fraction1numerator = Int(pow(Double(fraction1numerator),2))
            fraction1denominator = Int(pow(Double(fraction1denominator),2))
        }else if num1IsSquare{
            num1 = pow(num1,2)
        }
        // Squaring num2
        if num2IsSquare && fraction2numerator != 0 && fraction2denominator != 0 && num2 == 0{
            fraction2numerator = Int(pow(Double(fraction2numerator),2))
            fraction2denominator = Int(pow(Double(fraction2denominator),2))
        }else if num2IsSquare{
            num2 = pow(num2,2)
        }
    }
    
    // Greater common denomintor
    func gcd(num1: Int, num2: Int) -> Int {
        if num2 == 0{return num1}
        else {return gcd(num1:num2, num2:num1 % num2)}
    }
    
    // Result converter from fraction to decimal and viceversa
    func resultConverter(){
        
        if fraction1numerator == 0 && fraction1denominator == 0{
            resultNumerator = Int(num1 * Double(num1DecimalMultiplier))
            resultDenominator = Int(num1DecimalMultiplier)
            fractionSimplifier()
            if num1IsSquare{
                result = pow(num1,2)
            }
            
        }else{
            
            mixToFraction()
            if num1IsSquare{
                resultNumerator = Int(pow(Double(fraction1numerator),2))
                resultDenominator = Int(pow(Double(fraction1denominator),2))
                result = 0
            }else{
                result = Double(fraction1numerator) / Double(fraction1denominator)
            }
            
        }
    }
    
    // Improper fraction builder
    func mixToFraction(){
        if num1 != 0 && fraction1numerator != 0{
            if num1 > 0{
                fraction1numerator = (fraction1denominator * Int(num1)) + fraction1numerator
                num1 = 0}
            else{
                fraction1numerator = -1 * ( -1 * (fraction1denominator * Int(num1)) + fraction1numerator)
                num1 = 0
            }
        }
        
        if num2 != 0 && fraction2numerator != 0{
            if num2 > 0{
                fraction2numerator = (fraction2denominator * Int(num2)) + fraction2numerator
                num2 = 0}
            else{
                fraction2numerator = -1 * ( -1 * (fraction2denominator * Int(num2)) + fraction2numerator)
                num2 = 0
            }
        }
    }
    
    // int into fraction converter
    func intToFraction(){

        if fraction2numerator == 0  && fraction2denominator == 0{
            
            if num2 == floor(num2){
                fraction2numerator = Int(num2)
                fraction2denominator = 1
                num2 = 0
            }else{
                fraction2numerator = Int(num2 * Double(num2DecimalMultiplier))
                fraction2denominator = Int(num2DecimalMultiplier)
                num2 = 0
            }
        }
        else if fraction1numerator == 0  && fraction1denominator == 0{
            
            if num1 == floor(num1){
                fraction1numerator = Int(num1)
                fraction1denominator = 1
                num1 = 0
            }else {
                fraction1numerator = Int(num1 * Double(num1DecimalMultiplier))
                fraction1denominator = Int(num1DecimalMultiplier)
                num1 = 0
            }
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
            result += Double(resultNumerator / resultDenominator)
            resultNumerator = resultNumerator % resultDenominator
            if resultDenominator < 0{
                resultDenominator *= -1
            }
        }else if resultNumerator < 0{
            result += Double(resultNumerator / resultDenominator)
            resultNumerator = -1 * (resultNumerator % resultDenominator)
        }
    }
    
    func correctingResult(){
        if resultDenominator == 1{
            result = result + Double(resultNumerator)
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
        self.num1IsSquare = false
        self.num2IsSquare = false
    }
    func add(){
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            // Squaring numbers
            squareNumbers()
            
            result = num1 + num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            squareNumbers()
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
            // Squaring numbers
            squareNumbers()
            
            self.result = self.num1 * self.num2}
        
        else{
            // Multipliying fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            squareNumbers()
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
            // Squaring numbers
            squareNumbers()
            result = num1 - num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            squareNumbers()
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
                // Squaring numbers
                squareNumbers()
                result = self.num1 / self.num2}
        }
        
        else{
            // Dividing fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            squareNumbers()
            // Multiplying
            resultNumerator = fraction1numerator * fraction2denominator
            resultDenominator = fraction1denominator * fraction2numerator
            // Simplifying fraction
            fractionSimplifier()
            // Making sure fraction it is still a fraction
            correctingResult()
        }
    }

    func porcentOf(){
        // Processing number 1
        if fraction1numerator == 0  && fraction1denominator == 0{
            // Squaring numbers
            squareNumbers()
            num1IsSquare = false
            num2IsSquare = false
            num1 = num1 / 100
        }else{
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            squareNumbers()
            // Getting decimal value
            num1 = Double(fraction1numerator) / Double(fraction1denominator)
            fraction1numerator = 0
            fraction1denominator = 0
            num1 = num1 / 100
        }
        
        // Calculating percentage
        multiply()
    }
}
