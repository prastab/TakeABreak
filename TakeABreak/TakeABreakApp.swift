//
//  TakeABreakApp.swift
//  TakeABreak
//
//  Created by Prastab Ghimire on 1/1/25.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApplication.shared.setActivationPolicy(.regular)
    }
}

@main
struct TakeABreakApp: App {
    @StateObject var timerViewModel = TimerViewModel()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        timerViewModel.loadSettings()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(timerViewModel)
        }
    }
}
