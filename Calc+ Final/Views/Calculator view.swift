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
    @State var num1power = ""
    @State var num2power = ""
    @State var numPower = ""
    @State var typingPower = false
    
    @State var num1Sqroot = false
    @State var num2Sqroot = false
    @State var numSqroot = false
    @State var num1Rootdash = ""
    @State var num2Rootdash = ""
    @State var numRootdash = ""
    
    @State var fractionButtonImage = "emptyFractionButton"
    
    @State var copyNum = ""
    @State var copyNumerator = ""
    @State var copyDenominator = ""
    @State var copyFractionSlash = ""
    @State var copyIsNumNegative = false
    @State var copyNumHasFraction = false
    @State var copyIsFractionNegative = false
    @State var copyNumIsSquare = false
    @State var copyHasRoot = false
    @State var copyRootDash = ""
    @State var numberStoredText = ""
    
    
    // Aligments test
//    @State var upNum1 = "36"
//    @State var upFractionNumerator1 = "10"
//    @State var upFraction1Slash = "__"
//    @State var upFractionDenominator1 = "3"
//    @State var upUnit1 = ""
//
//    @State var currOp = "+"
//
//    @State var upNum2 = "63"
//    @State var upFractionNumerator2 = "9"
//    @State var upFraction2Slash = "_"
//    @State var upFractionDenominator2 = "9"
//    @State var upUnit2 = ""
//
//    @State var num = "400"
//    @State var numerator = "2"
//    @State var fractionSlash = "_"
//    @State var denominator = "3"
//    @State var unit = ""
//
//    @State var num1HasFraction = true
    //@State var num2HasFraction = true
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
//    @State var num1power = "2"
//    @State var num2power = "2"
//    @State var numPower = "2"
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
                    
                }, label: {Image("feetButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {clearAll()
                    
                }, label: {Image("inchButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {transferValue(op: "% of")
                    
                }, label: {Image("yardButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {copy()
                }, label: {Image("copyButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {paste()
                    
                }, label: {Image("pasteButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
            }
            
            HStack{
                Button(action: {clear()
                    
                }, label: {Image("clearButton").resizable().scaledToFit()})
                
                Button(action: {clearAll()
                    
                }, label: {Image("clearAllButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {transferValue(op: "% of")
                    
                }, label: {Image("percentButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {transferValue(op: "÷")
                }, label: {Image("divideButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {sqroot()
                    
                }, label: {Image("sqrootButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "7")
                    
                }, label: {Image("sevenButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "8")
                    
                }, label: {Image("eightButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "9")
                    
                }, label: {Image("nineButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "×")
                    
                }, label: {Image("multiplyButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {toThePower()
                    
                }, label: {Image(typingPower ?  "exitButton" : "powerButton" ).resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator  ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "4")
                    
                }, label: {Image("fourButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "5")
                    
                }, label: {Image("fiveButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "6")
                    
                }, label: {Image("sixButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "−")
                    
                }, label: {Image("minusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {squared()
                    
                }, label: {Image("squareButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
            }
            
            HStack{
                Button(action: {buttonTaped(number: "1")
                    
                }, label: {Image("oneButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "2")
                    
                }, label: {Image("twoButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: "3")
                    
                }, label: {Image("threeButton").resizable().scaledToFit()})
                
                Button(action: {transferValue(op: "+")
                    
                }, label: {Image("plusButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {plusMinus()
                    
                }, label: {Image("plusMinusBigButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
            }
            
            HStack{
                Button(action: {buttonTaped(number: "0")
                    
                }, label: {Image("zeroButton").resizable().scaledToFit()})
                
                Button(action: {buttonTaped(number: ".")
                    
                }, label: {Image("pointButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                Button(action: {back()
                    
                }, label: {Image("deleteButton").resizable().scaledToFit()})
                
                
                Button(action: {if !numIsDecimal{typingAFraction()}
                    
                }, label: {Image( self.fractionButtonImage
                ).resizable().scaledToFit()}).opacity(typingPower ? 0 : 1)
                
                Button(action: {equal()
                    
                }, label: {Image("equalButton").resizable().scaledToFit()}).opacity(typingNumerator || typingDenominator || typingPower ? 0 : 1)
                
                
                
            }
        }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
    // Views-------------------------------------------------------------------------
    
    var num1View: some View{
        Group{
            if num1Sqroot && num1HasFraction{
                
                Text("√").font(.system(size: 63)).offset(x: 14)
            }
            else if num1Sqroot{
                Group{
                    ZStack{
                        Text("√").font(.system(size: 40)).offset(x: 8)
                        //Text("_").font(.system(size: 40)).offset(x: 20, y: -39)
                        
                    }
                }
            }
            ZStack{
                Group{
                    if num1Sqroot && num1HasFraction{
                        Text(self.num1Rootdash).bold().font(.system(size: 50)).offset(x: 0, y: -55)
                    }else if num1Sqroot{
                        Text(self.num1Rootdash).font(.system(size: 40)).offset(x: 0, y: -39)
                    }}
                Group{
                    HStack{
                        if num1IsSquare && num1HasFraction{ Text("(").font(.system(size: 40))}
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
                        if num1IsSquare && num1HasFraction{ Text(")").font(.system(size: 40))}
                        if num1IsSquare{Text(self.num1power).font(.system(size: 15)).offset(x:-5, y: -10)}
                        if num1HasUnit{Text(self.upUnit1)}
                    }
                }.frame(width: .infinity)
            }
            // Operator
            Text(self.currOp).font(.system(size:30))
                .lineLimit(1)
        }
    }
//---------------------------------------------------------------------------------------------
    var num2View: some View{
        Group{
            Group{
                if num2Sqroot && num2HasFraction{
                    
                    Text("√").font(.system(size: 63)).offset(x: 14)
                }
                else if num2Sqroot{
                    ZStack{
                        Text("√").font(.system(size: 40)).offset(x: 8)
                        //Text("_").font(.system(size: 40)).offset(x: 20, y: -39)
                        
                    }
                }}
            ZStack{
                Group{
                    if num2Sqroot && num2HasFraction{
                        Text(self.num2Rootdash).font(.system(size: 50)).offset(x: 0, y: -55)
                    }else if num2Sqroot{
                        Text(self.num2Rootdash).font(.system(size: 40)).offset(x: 0, y: -39)
                    }}
                HStack{
                    // If number is negative
                    if self.num2IsNegative || self.num2IsSquare || self.num2FractionIsNegative{ Text("(").font(.system(size: 40)) }
                    
                    if self.upNum2 != ""{
                        Group{
                            
                            
                            Text(self.upNum2)
                            
                            
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
                    if self.num2FractionIsNegative || self.num2IsNegative || self.num2IsSquare{ Text(")").font(.system(size: 40))}
                    
                    // Number 2 unit or is squared
                    if num2IsSquare{Text(self.num2power).font(.system(size: 15)).offset(x:-5, y: -10)}
                    if num2HasUnit{Text(self.upUnit2)}
                }
            }
        }
    }
//---------------------------------------------------------------------------------------------

    var numView: some View{
        Group{
            HStack{
                Group{
                    if self.num.count < 8 {Spacer()}
                    
                    if numSqroot && numHasFraction{
                        
                        Text("√").font(.system(size: 75)).offset(x: 14)
                        
                    }
                    else if numSqroot{
                        ZStack{
                            Text("√").font(.system(size: 60)).offset(x: 10)
                            //Text("_").font(.system(size: 60)).offset(x: 35, y: -58)
                            
                        }
                    }}
                ZStack{
                    Group{
                        if numSqroot && numHasFraction{
                            Text(self.numRootdash).font(.system(size: 69)).offset(x:0, y: -70)
                        }else if numSqroot{
                            Text(self.numRootdash).font(.system(size: 64)).offset(x: 0, y: -60)
                        }}
                    HStack{
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
                        if numIsSquare{Text(self.numPower).font(.system(size: 30)).offset(x:-5, y: -10)}
                        if numHasUnit{Text(self.unit)}
                    }
                }.frame(width: .infinity)
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
        // Keeping the result
        if !noNum1() && noNumber(){
            self.num = self.upNum1
            if self.num1HasFraction{
                self.numHasFraction = true
                self.numerator = self.upFractionNumerator1
                self.denominator = self.upFractionDenominator1
                self.fractionSlash = self.upFraction1Slash
            }
            self.unit = self.upUnit1
        }
        
        // Typing firt number
        if self.currOp == ""{
            self.num1IsSquare = !self.num1IsSquare
            if self.num1IsSquare{
                self.num1power = "2"}
            else{self.num1power = ""}
            
        }else{
            self.num2IsSquare = !self.num2IsSquare
            if self.num2IsSquare{
                self.num2power = "2"}
            else{self.num2power = ""}
            
        }
        self.numIsSquare = !self.numIsSquare
        if self.numIsSquare{
            self.numPower = "2"}
        else{self.numPower = ""}
        
        
        rootDashClear()
        rootDashResizer()
    }
    
    func toThePower(){
        // Keeping the result
        if !noNum1() && noNumber(){
            self.num = self.upNum1
            if self.num1HasFraction{
                self.numHasFraction = true
                self.numerator = self.upFractionNumerator1
                self.denominator = self.upFractionDenominator1
                self.fractionSlash = self.upFraction1Slash
            }
            self.unit = self.upUnit1
        }
        
        // Turning off the buttons not needed to type power
        self.typingPower = !self.typingPower
        // Turning on power views
        if noNum2() && self.currOp == ""{
            self.num1IsSquare = true
            if self.numPower == ""{
                self.num1power = "0"}
        }
        else{
            self.num2IsSquare = true
            if self.numPower == ""{
                self.num2power = "0"}
            if self.upNum2 == "" && !self.num2HasFraction{
                self.upNum2 = "0"
            }
        }
        
        self.numIsSquare = true
        if self.numPower == ""{
            self.numPower = "0"}
        
        rootDashClear()
        rootDashResizer()
    }
    
    func rootDashResizer(){
        // Determining the size of the root line
        if numSqroot{
            
            var count = self.num.count
            
            if self.numHasFraction && self.numIsSquare{
                if self.numerator.count > self.denominator.count{
                    count += self.numerator.count
                }else{
                    count += self.denominator.count
                }
                // Parentheses
                count += 2
            }
            else if self.numHasFraction{
                if self.numerator.count > self.denominator.count{
                    count += self.numerator.count
                }else{
                    count += self.denominator.count
                }
            }
            else if self.numIsSquare{
                count += 1
            }
            
            else if self.numIsNegative{
                count += 1
            }
            
            for i in 1...count{
                // Resizing
                self.numRootdash = "\(self.numRootdash)" + "_"
                if noNum2() && self.currOp == ""{
                    self.num1Rootdash = "\(self.num1Rootdash)" + "_"
                }else{
                    self.num2Rootdash = "\(self.num2Rootdash)" + "_"
                }

                if i % 4 == 0{
                    self.numRootdash = "\(self.numRootdash)" + "_"
                }
                
//                if i % 5 == 0{
//                    if noNum2() && self.currOp == ""{
//                        self.num1Rootdash = "\(self.num1Rootdash)" + "_"
//                    }else{
//                        self.num2Rootdash = "\(self.num2Rootdash)" + "_"
//                    }
//                }
                    
            }
            
            count = 0
            
        }else{
            rootDashClear()
        }
    }
    func rootDashClear(){
        self.numRootdash = ""
        if noNum2() && self.currOp == ""{
            self.num1Rootdash = ""
        }else{
            self.num2Rootdash = ""
        }
    }
    func sqroot(){
        
        // Keeping the result
        if !noNum1() && noNumber() && self.currOp == ""{
            self.num = self.upNum1
            if self.num1HasFraction{
                self.numHasFraction = true
                self.numerator = self.upFractionNumerator1
                self.denominator = self.upFractionDenominator1
                self.fractionSlash = self.upFraction1Slash
            }
            self.unit = self.upUnit1
        }
        
        if noNum2() && self.currOp == ""{
            self.num1Sqroot = !self.num1Sqroot
        }else{
            self.num2Sqroot = !self.num2Sqroot
            if self.upNum2 == ""{
                self.upNum2 = "0"
            }
        }
        self.numSqroot = !self.numSqroot
        rootDashClear()
        rootDashResizer()
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
            self.copyHasRoot = self.num1Sqroot
            self.copyRootDash = self.num1Rootdash
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
            self.copyHasRoot = self.numSqroot
            self.copyRootDash = self.numRootdash
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
                self.num1Sqroot = self.copyHasRoot
                self.num1Rootdash = self.copyRootDash
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
                self.num2Sqroot = self.copyHasRoot
                self.num2Rootdash = self.copyRootDash
            }
            // Pasting to num
            self.num = self.copyNum
            self.numerator = self.copyNumerator
            self.denominator = self.copyDenominator
            self.fractionSlash = self.copyFractionSlash
            self.numIsNegative = self.copyIsNumNegative
            self.numIsNegative = self.copyIsFractionNegative
            self.numHasFraction = self.copyNumHasFraction
            self.numIsSquare = self.copyNumIsSquare
            self.numSqroot = self.copyHasRoot
            self.numRootdash = self.copyRootDash
            
            // Clearing memory
            self.copyNum = ""
            self.copyNumerator = ""
            self.copyDenominator = ""
            self.copyFractionSlash = ""
            self.copyIsNumNegative = false
            self.copyIsFractionNegative = false
            self.copyNumHasFraction = false
            self.copyNumIsSquare = false
            self.copyHasRoot = false
            self.copyRootDash = ""
            self.numberStoredText = ""
        }
    }
    func plusMinus(){
        // Typing firt number
        if noNum2() && self.currOp == ""{
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
        
        rootDashClear()
        rootDashResizer()
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
        if numIsSquare{
            self.num1power = self.numPower
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
        if numIsSquare{
            self.num2power = self.numPower
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
        rootDashClear()
        rootDashResizer()
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
        if self.numIsSquare{
            self.numPower = ""
        }
        if self.numSqroot{
            self.numRootdash = ""
        }
        self.numIsNegative = false
        self.numIsSquare = false
        self.numSqroot = false
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
        if self.num1IsSquare{
            self.num1power = ""
        }
        if self.num1Sqroot{
            self.num1Rootdash = ""
        }
        self.num1IsNegative = false
        self.num1IsSquare = false
        self.num1Sqroot = false
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
        if self.num2IsSquare{
            self.num2power = ""
        }
        if self.num2Sqroot{
            self.num2Rootdash = ""
        }
        self.num2IsSquare = false
        self.num2Sqroot = false
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
        
        else if self.typingPower{
            if self.numPower == "0"{
                self.numPower = ""
                self.numIsSquare = false
                self.typingPower = false
                if noNum2() && self.currOp == ""{
                    self.num1IsSquare = false
                }else{
                    self.num2IsSquare = false
                }
                
            }else{
                self.numPower = "0"
            }
            if noNum2() && self.currOp == ""{
                copyNumToNum1()
            }else{
                copyNumToNum2()
            }
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
        
        // Clearing number stored
        self.copyNum = ""
        self.copyNumerator = ""
        self.copyDenominator = ""
        self.copyFractionSlash = ""
        self.copyIsNumNegative = false
        self.copyIsFractionNegative = false
        self.copyNumHasFraction = false
        self.copyNumIsSquare = false
        self.numberStoredText = ""
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
        // Deleting numbers while typing a power
        else if typingPower{
            // Removing char from num power
            self.numPower.removeLast()
            if self.numPower.isEmpty{
                self.numPower = "0"
            }
            // Copying numbers
            if noNum2() && self.currOp == ""{
                copyNumToNum1()
            }else{
                copyNumToNum2()
            }
        }
        else if self.num2Sqroot{
            self.num2Sqroot = false
            self.numSqroot = false
        }
        // Deleting number 2 power
        else if self.num2IsSquare{
            self.num2IsSquare = false
            self.numIsSquare = false
            self.num2power = ""
            self.numPower = ""
        }
        // Deleting number 2 fration
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
        // Deleting number 2
        else if self.upNum2 != ""{
            self.upNum2.removeLast()
            self.num.removeLast()
            if self.upNum2 == "-" || self.num == "-"{
                self.upNum2 = ""
                self.num = "0"
                self.num2IsNegative = false
                self.numIsNegative = false
                
            }
        }
        // Deleting operator
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
        else if self.num1Sqroot{
            self.num1Sqroot = false
            self.numSqroot = false
        }
        // Deleting number 1 power
        else if self.num1IsSquare{
            self.num1IsSquare = false
            self.numIsSquare = false
            self.num1power = ""
            self.numPower = ""
        }
        // Deleting number 1 fraction
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
        }
        // Deleting number 1
        else{
            //self.currOp = ""
            self.upNum1.removeLast()
            self.num.removeLast()
            if self.upNum1 == "-" || self.num == "-"{
                self.upNum1 = "0"
                self.num = "0"
                self.num1IsNegative = false
                self.numIsNegative = false
                
            }
        }
        
        // Save guard if value is empty
        if self.upNum1.isEmpty || self.num.isEmpty{
            if self.num.isEmpty && !self.numHasFraction{self.num = "0"}
            if self.upNum1.isEmpty && !self.num1HasFraction{self.upNum1 = "0"}
        }
        
        rootDashClear()
        rootDashResizer()
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
    // This functions sends the number 1 to the calculator class instance and it sets the operator
    func transferValue(op: String){
        
        // Safe guards against multiple opperators
        if self.currOp != "" {
            // Performing calculation if operator is tapped
            equal()
            transferValue(op: op)
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
            calc.num1HasRoot = self.num1Sqroot
            calc.num1Power = Double(self.num1power) ?? 0
            
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
        // Calculating the square or root of a number
        if (self.num1Sqroot || num1IsSquare) && noNum2() && self.currOp == ""{
            // inputing the fraction
            if self.num1HasFraction{
                calc.fraction1numerator = Int(self.upFractionNumerator1) ?? 0
                calc.fraction1denominator = Int(self.upFractionDenominator1) ?? 0
            }
            // inputing number
            self.calc.num1 = Double(self.upNum1) ?? 0
            calc.num1Power = Double(self.num1power) ?? 0
            calc.num1IsSquare = self.num1IsSquare
            calc.num1HasRoot = self.num1Sqroot
//            if num1Sqroot || num1IsSquare{
//
//
//            }
            
            calc.resultConverter()
            displayFraction()
            displayNum()
            calc.clear()
        }
        // Converting result from decimal to fraction
        else if noNum2() && self.currOp == ""{
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
        calc.num2HasRoot = self.num2Sqroot
        calc.num2Power = Double(self.num2power) ?? 0
        
        
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
        self.num1Sqroot = false
        
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
            
        else if self.typingPower{
            // Removing one
            if self.numPower == "0"{
                self.numPower = ""
            }
            // Typing denominator
            self.numPower = "\(self.numPower)\(number)"
            
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
        
        rootDashClear()
        rootDashResizer()
        
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
    var num1Power:Double = 0
    var num1IsSquare = false
    var num1HasRoot = false
    var numerator1Root = ""
    var denominator1Root = ""
    
    var num2:Double = 0
    var fraction2numerator:Int = 0
    var fraction2denominator:Int = 0
    var num2DecimalMultiplier:Float = 0
    var num2Power:Double = 0
    var num2IsSquare = false
    var num2HasRoot = false
    var numerator2Root = ""
    var denominator2Root = ""
    
    var result:Double = 0
    var resultNumerator: Int = 0
    var resultDenominator: Int = 0
    
    var gcd = 0
    
    func sqroot(){
        if num1HasRoot{
            // Number 1 fraction
            if fraction1numerator != 0 && fraction1denominator != 0{
                num1 = Double(fraction1numerator) / Double(fraction1denominator)
                fraction1numerator = 0
                fraction1denominator = 0
                num1 = num1.squareRoot()
            }else{
                num1 = num1.squareRoot()
            }
            num1HasRoot = false
            
            // Turning fraction 2 into decimal to complete calculation
            if fraction2numerator != 0 || fraction2denominator != 0 && !num2HasRoot{
                num2 = Double(fraction2numerator) / Double(fraction2denominator)
                fraction2numerator = 0
                fraction2denominator = 0
            }
            
//            if fraction1numerator != 0{
//                numerator1Root = String(Double(fraction1numerator).squareRoot())
//                denominator1Root = String(Double(fraction1denominator).squareRoot())
//
//                if numerator1Root.contains(".") || denominator1Root.contains("."){
//                    num1 = (Double(numerator1Root) ?? 0) / (Double(denominator1Root) ?? 1)
//                    // Clean up
//                    numerator1Root = ""
//                    denominator1Root = ""
//                    fraction1numerator = 0
//                    fraction1denominator = 0
//
//                }
//                else{
//                    fraction1numerator = Int(numerator1Root) ?? 0
//                    fraction1denominator = Int(denominator1Root) ?? 0
//                }
//
//            }else{
//                num1 = num1.squareRoot()
//            }
        }
        
        if num2HasRoot{
            // Number 2 fraction
            if fraction2numerator != 0 && fraction2denominator != 0{
                num2 = Double(fraction2numerator) / Double(fraction2denominator)
                fraction2numerator = 0
                fraction2denominator = 0
                num2 = num2.squareRoot()
            }else{
                num2 = num2.squareRoot()
            }
            num2HasRoot = false
            
            // Turning fraction 1 into decimal to complete calculation
            if fraction1numerator != 0 || fraction1denominator != 0 && !num1HasRoot{
                num1 = Double(fraction1numerator) / Double(fraction1denominator)
                fraction1numerator = 0
                fraction1denominator = 0
            }
            // Number 2 fraction
//            if fraction2numerator != 0{
//                numerator2Root = String(Double(fraction2numerator).squareRoot())
//                denominator2Root = String(Double(fraction2denominator).squareRoot())
//
//                if numerator2Root.contains(".") || denominator2Root.contains("."){
//                    num2 = (Double(numerator2Root) ?? 0) / (Double(denominator2Root) ?? 1)
//                    // Clean up
//                    numerator1Root = ""
//                    denominator1Root = ""
//                    fraction1numerator = 0
//                    fraction1denominator = 0
//
//                }
//                else{
//                    fraction2numerator = Int(numerator2Root) ?? 0
//                    fraction2denominator = Int(denominator2Root) ?? 0
//                }
//
//            }else{
//                num2 = num2.squareRoot()
//            }
        }
    }
    
    
    // Squaring Number NOTE: Does not work on mixed numbers
    func powerNumbers(){
        // Squaring num1
        if num1IsSquare && fraction1numerator != 0 && fraction1denominator != 0 && num1 == 0{
            fraction1numerator = Int(pow(Double(fraction1numerator),num1Power))
            fraction1denominator = Int(pow(Double(fraction1denominator),num1Power))
        }else if num1IsSquare{
            num1 = pow(num1,num1Power)
        }
        // Squaring num2
        if num2IsSquare && fraction2numerator != 0 && fraction2denominator != 0 && num2 == 0{
            fraction2numerator = Int(pow(Double(fraction2numerator),num2Power))
            fraction2denominator = Int(pow(Double(fraction2denominator),num2Power))
        }else if num2IsSquare{
            num2 = pow(num2,num2Power)
        }
        // Cleaning the powers
        if num1IsSquare{
            num1IsSquare = false
        }
        else if num2IsSquare{
            num2IsSquare = false
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
                num1 = pow(num1,num1Power)
            }
            if num1HasRoot{
                sqroot()
                
            }
            if num1IsSquare || num1HasRoot{
                result = num1
            }
        }
        else{
            
            mixToFraction()
            if num1HasRoot && !num1IsSquare{
                sqroot()
                result = num1
            }
            else if !num1HasRoot && num1IsSquare{
                resultNumerator = Int(pow(Double(fraction1numerator),num1Power))
                resultDenominator = Int(pow(Double(fraction1denominator),num1Power))
            }
            else if num1HasRoot && num1IsSquare{
                fraction1numerator = Int(pow(Double(fraction1numerator),num1Power))
                fraction1denominator = Int(pow(Double(fraction1denominator),num1Power))
                
                sqroot()
                
                result = num1
            }
            
            else{
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
        self.num1HasRoot = false
        self.num2HasRoot = false
    }
    
    // Operations-----------------------------------------------------------
    func add(){
        if fraction1numerator == 0 && fraction1denominator == 0 && fraction2numerator == 0 && fraction2denominator == 0{
            // Squaring numbers
            powerNumbers()
            // Root square
            sqroot()
            result = num1 + num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            powerNumbers()
            // Root square
            if num1HasRoot || num2HasRoot{
                sqroot()
                add()
            }
//            if fraction1numerator == 0 && fraction1denominator == 0 || fraction2numerator == 0 &&
//                fraction2denominator == 0{
//                // Turning remaining fractions into decimal
//                if fraction1numerator == 0 && fraction1denominator == 0{
//                    num2 = Double(fraction2numerator) / Double(fraction2denominator)
//                    fraction2numerator = 0
//                    fraction2denominator = 0
//                    num1HasRoot = false
//                }
//                else if fraction2numerator == 0 && fraction2denominator == 0{
//                    num2 = Double(fraction2numerator) / Double(fraction2denominator)
//                    fraction1numerator = 0
//                    fraction1denominator = 0
//                    num2HasRoot = false
//                }
//                add()
//            }
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
            powerNumbers()
            // Root square
            sqroot()
            
            self.result = self.num1 * self.num2}
        
        else{
            // Multipliying fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            powerNumbers()
            // Root square
            if num1HasRoot || num2HasRoot{
                sqroot()
                multiply()
            }
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
            powerNumbers()
            // Root square
            sqroot()
            result = num1 - num2
        }
        else{
            // substracting fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            powerNumbers()
            // Root square
            if num1HasRoot || num2HasRoot{
                sqroot()
                substract()
            }
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
                powerNumbers()
                // Root square
                sqroot()
                result = self.num1 / self.num2}
        }
        
        else{
            // Dividing fractions
            intToFraction()
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            powerNumbers()
            // Root square
            if num1HasRoot || num2HasRoot{
                sqroot()
                divide()
            }
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
            powerNumbers()
            num1IsSquare = false
            num2IsSquare = false
            num1 = num1 / 100
        }else{
            // Building improper fraction
            mixToFraction()
            // Squaring numbers
            powerNumbers()
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
