//
//  Calc__FinalApp.swift
//  Calc+ Final
//
//  Created by Alfredo Borroto on 10/22/22.
//

import SwiftUI

@main
struct Calc__FinalApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            //BubbleLevelView(detector: MotionDetector())
            Calculator_view(detector: MotionDetector())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?)-> UIInterfaceOrientationMask{
        return AppDelegate.orientationLock
    }
}
