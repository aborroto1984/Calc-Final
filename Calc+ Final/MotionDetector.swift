//
//  MotionDetector.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/22/22.
//

import CoreMotion
import UIKit

class MotionDetector: ObservableObject{
    private let motionManager = CMMotionManager()
    private var timer = Timer()
    
    @Published var x: Double = 0
    @Published var y: Double = 0
    @Published var z: Double = 0

    func start(){
        if motionManager.isDeviceMotionAvailable {
            motionManager.startDeviceMotionUpdates()
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.updateMotionData()
                        }
        }
    }

    init(){
            start()
    }
    
    func updateMotionData() {
        
        if let data = motionManager.deviceMotion {
            x = data.attitude.pitch
            y = data.attitude.roll
            z = data.userAcceleration.z
        }
    }
        
    func stop() {
        motionManager.stopDeviceMotionUpdates()
        timer.invalidate()
        x = 0
        y = 0
        z = 0
    }

    deinit {
            stop()
    }
}
