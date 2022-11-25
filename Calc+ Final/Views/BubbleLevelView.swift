//
//  ContentView.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/22/22.
//

import SwiftUI

struct BubbleLevelView: View {
    
    @StateObject var detector: MotionDetector
    
    let range = Double.pi
    let levelSize: CGFloat = 325


    
    var bubbleXPosition: CGFloat {
            let zeroBasedRoll = detector.x + range / 2
            let rollAsFraction = zeroBasedRoll / range
            return rollAsFraction * levelSize
        }
    
    var bubbleYPosition: CGFloat {
            let zeroBasedPitch = detector.y + range / 2
            let pitchAsFraction = zeroBasedPitch / range
            return pitchAsFraction * levelSize
        }
    
    
    var body: some View {
        VStack {
            Text("\(bubbleXPosition)")
            Text("\(bubbleYPosition)")
            
            ZStack{
                Image("Center Level Back").resizable().scaledToFit().frame(width: 350)
                
                Image("Bubble asset").resizable().scaledToFit().frame(width: 50).position(x: bubbleXPosition,y: bubbleYPosition)
                
                Image("Center Level Markings").resizable().scaledToFit().frame(width: 325)
            }
            
            
        }.onAppear {
            detector.start()}.onDisappear {
                detector.stop()}
    }
}

struct BubbleLevel_Previews: PreviewProvider {
    @StateObject static var detector = MotionDetector()

    static var previews: some View {
        BubbleLevelView(detector: detector).environmentObject(detector)
        
    }
}



