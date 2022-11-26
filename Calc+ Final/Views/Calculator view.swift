//
//  Calculator view.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/23/22.
//

import SwiftUI

struct Calculator_view: View {
    
    @StateObject var detector: MotionDetector
    @State var upValue = "0"
    @State var value = "0"
    @State var currOpp = ""
    @State var num1 = 0
    @State var num2 = 0
    
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
                }
                
                
                HStack{
                    
                    Button(action: {
                        
                    }, label: {Image("feetButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("inchButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("yardButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("copyButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("pasteButton").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {clear()
                        
                    }, label: {Image("clearButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("plusMinusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("percentButton").resizable().scaledToFit()})
                    
                    Button(action: {transferValue(opp: "÷")
                    }, label: {Image("divideButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver2Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {buttonTaped(number: "7")
                        
                    }, label: {Image("sevenButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "8")
                        
                    }, label: {Image("eightButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "9")
                        
                    }, label: {Image("nineButton").resizable().scaledToFit()})
                    
                    Button(action: {transferValue(opp: "×")
                        
                    }, label: {Image("multiplyButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver4Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {buttonTaped(number: "4")
                        
                    }, label: {Image("fourButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "5")
                        
                    }, label: {Image("fiveButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "6")
                        
                    }, label: {Image("sixButton").resizable().scaledToFit()})
                    
                    Button(action: {transferValue(opp: "−")
                        
                    }, label: {Image("minusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver8Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {buttonTaped(number: "1")
                        
                    }, label: {Image("oneButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "2")
                        
                    }, label: {Image("twoButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: "3")
                        
                    }, label: {Image("threeButton").resizable().scaledToFit()})
                    
                    Button(action: {transferValue(opp: "+")
                        
                    }, label: {Image("plusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver16Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {buttonTaped(number: "0")
                        
                    }, label: {Image("zeroButton").resizable().scaledToFit()})
                    
                    Button(action: {buttonTaped(number: ".")
                        
                    }, label: {Image("pointButton").resizable().scaledToFit()})
                    
                    Button(action: {back()
                        
                    }, label: {Image("deleteButton").resizable().scaledToFit()})
                    
                    Button(action: {equal()
                        
                    }, label: {Image("equalButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("emptyFractionButton").resizable().scaledToFit()})
                    
                }
            }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
       
    func clear(){
        
        if self.value == "0"{
            self.value = "0"
            self.upValue = "0"
        }
        else{
            self.value = "0"
        }
        
    }
    
    func back(){
        if  self.value != "0"{
            self.value.removeLast()
            self.upValue.removeLast()
        }
        else{
            self.value.removeLast()
        }
        
        // Access null violation fail safe
        
        if self.value.isEmpty || self.value == "0"{
            self.value = "0"
        }
        
    }
    
    func transferValue(opp: String){
        self.upValue = "\(self.value)\(opp)"
        self.num1 = Int(self.value) ?? 0
        self.currOpp = opp
        self.value = "0"
    }
    
    func equal(){
        self.num2 = Int(self.value) ?? 0
        
        switch self.currOpp{
        case "+":
            self.num1 = self.num1 + self.num2
            self.upValue = String(self.num1)
            break
        case "−":
            self.num1 = self.num1 - self.num2
            self.upValue = String(self.num1)
            break
        case "×":
            self.num1 = self.num1 * self.num2
            self.upValue = String(self.num1)
            break
        case "÷":
            self.num1 = self.num1 / self.num2
            self.upValue = String(self.num1)
            break
        default:
            break

        }
    }
    func buttonTaped(number: String){
        if self.value.count < 8 {
            if self.value == "0" && number == "." {
                self.value = "\(self.value)\(number)"
            }
            else if self.value == "0" {
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
            
            if self.upValue != "0"{
                self.upValue = "\(self.upValue)\(number)"
            }
        }
    }
    
    struct Calculator_view_Previews: PreviewProvider {
        
        @StateObject static var detector = MotionDetector()
        
        static var previews: some View {
            Calculator_view(detector: detector).environmentObject(detector)
        }
    }}
