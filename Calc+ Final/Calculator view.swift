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
            Image("header").offset(y: -250)
            
            HStack{
                VStack{
                    NavigationLink(destination: BubbleLevelView(detector: detector)) {
                        Image("menu")
                    }
                    
                }.offset(x: -80, y: -330)
                
                
                VStack{ Text("Calculator").font(.largeTitle).foregroundColor(.black)}.offset(x: -14, y: -330)
                
                
            }
            
            
            
            HStack{
                
                Button(action: {
                    
                }, label: {Image("feetButton")})
                
                Button(action: {
                    
                }, label: {Image("inchButton")})
                
                Button(action: {
                    
                }, label: {Image("yardButton")})
                
                Button(action: {
                    
                }, label: {Image("copyButton")})
                
                Button(action: {
                    
                }, label: {Image("pasteButton")})
            }
            
            HStack{
                Button(action: {
                    
                }, label: {Image("clearButton")})
                
                Button(action: {
                    
                }, label: {Image("plusMinusButton")})
                
                Button(action: {
                    
                }, label: {Image("percentButton")})
                
                Button(action: {
                    
                }, label: {Image("divideButton")})
                
                Button(action: {
                    
                }, label: {Image("xOver2Button")})
            }
            
            HStack{
                Button(action: {
                    
                }, label: {Image("sevenButton")})
                
                Button(action: {
                    
                }, label: {Image("eightButton")})
                
                Button(action: {
                    
                }, label: {Image("nineButton")})
                
                Button(action: {
                    
                }, label: {Image("multiplyButton")})
                
                Button(action: {
                    
                }, label: {Image("xOver4Button")})
            }
            
            HStack{
                Button(action: {
                    
                }, label: {Image("fourButton")})
                
                Button(action: {
                    
                }, label: {Image("fiveButton")})
                
                Button(action: {
                    
                }, label: {Image("sixButton")})
                
                Button(action: {
                    
                }, label: {Image("minusButton")})
                
                Button(action: {
                    
                }, label: {Image("xOver8Button")})
            }
            
            HStack{
                Button(action: {
                    
                }, label: {Image("oneButton")})
                
                Button(action: {
                    
                }, label: {Image("twoButton")})
                
                Button(action: {
                    
                }, label: {Image("threeButton")})
                
                Button(action: {
                    
                }, label: {Image("plusButton")})
                
                Button(action: {
                    
                }, label: {Image("xOver16Button")})
            }
            
            HStack{
                Button(action: {
                    
                }, label: {Image("zeroButton")})
                
                Button(action: {
                    
                }, label: {Image("pointButton")})
                
                Button(action: {
                    
                }, label: {Image("deleteButton")})
                
                Button(action: {
                    
                }, label: {Image("equalButton")})
                
                Button(action: {
                    
                }, label: {Image("emptyFractionButton")})
                
            }
        }.offset(y:100).onAppear{UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation"); AppDelegate.orientationLock = .portrait}
    }
    
    struct Calculator_view_Previews: PreviewProvider {
        
        @StateObject static var detector = MotionDetector()
        
        static var previews: some View {
            Calculator_view(detector: detector).environmentObject(detector)
        }
    }}
