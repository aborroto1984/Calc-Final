//
//  Calculator view.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/23/22.
//

import SwiftUI


struct Calculator_view: View {
    
    @StateObject var detector: MotionDetector
    
    var body: some View {
    
            VStack{
    
                ZStack{
                    Image("header")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: .infinity, height: 100)
                        .scaledToFill()
                        .position()
                        
                    
                    
                    VStack{
                        ZStack{
//                            NavigationLink(destination: BubbleLevelView(detector: detector)) {
//                                Image("menu")
                            HStack{}
                            Image("menu")
                            
                        
                            
                            Text("Calculator")
//                                .frame(maxWidth: .infinity, alignment: .center)
                                .font(.largeTitle).foregroundColor(.black)
                            
                            
                            
                        }
                        Spacer()
                    }
                    
                    
                }
                
                Spacer()
                
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
                    Button(action: {
                        
                    }, label: {Image("clearButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("plusMinusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("percentButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("divideButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver2Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {Image("sevenButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("eightButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("nineButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("multiplyButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver4Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {Image("fourButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("fiveButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("sixButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("minusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver8Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {Image("oneButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("twoButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("threeButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("plusButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("xOver16Button").resizable().scaledToFit()})
                }
                
                HStack{
                    Button(action: {
                        
                    }, label: {Image("zeroButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("pointButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("deleteButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("equalButton").resizable().scaledToFit()})
                    
                    Button(action: {
                        
                    }, label: {Image("emptyFractionButton").resizable().scaledToFit()})
                    
                }
            }.onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}.padding()
    }
       
        
    
    
    struct Calculator_view_Previews: PreviewProvider {
        
        @StateObject static var detector = MotionDetector()
        
        static var previews: some View {
            Calculator_view(detector: detector).environmentObject(detector)
        }
    }}
