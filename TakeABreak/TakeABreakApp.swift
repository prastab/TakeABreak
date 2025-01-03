//
//  TakeABreakApp.swift
//  TakeABreak
//
//  Created by Prastab Ghimire on 1/1/25.
//

import SwiftUI
import UserNotifications

//@main
//struct TakeABreakApp: App {
////    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    @StateObject private var breakManager: BreakManager
//	@StateObject private var statusBarController: StatusBarController
//
//    init() {
//        let breakManagerInstance = BreakManager()
//        _breakManager = StateObject(wrappedValue: breakManagerInstance)
//		self._statusBarController = StateObject(wrappedValue: StatusBarController(breakManager: breakManagerInstance))
//
//    }
//    var body: some Scene {
//        Settings {
//            SettingsView()
//                .environmentObject(breakManager)
//        }
////        .onChange(of: breakManager) { newBreakManager in
////            appDelegate.breakManager = newBreakManager
////        }
//    }
//}

@main
struct TakeABreakApp: App {
	@StateObject private var breakManager = BreakManager.shared
	@StateObject private var statusBarController = StatusBarController()

	var body: some Scene {
		Settings {
			SettingsView()
				.environmentObject(breakManager)
		}
		.onChange(of: breakManager.breakInterval) { _ in
			NotificationCenter.default.post(name: NSNotification.Name("UpdateStatusMenu"), object: nil)
		}
		.onChange(of: breakManager.breakDuration) { _ in
			NotificationCenter.default.post(name: NSNotification.Name("UpdateStatusMenu"), object: nil)
		}
	}
}
