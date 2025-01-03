import SwiftUI

class StatusBarController: ObservableObject {
	private var statusItem: NSStatusItem
	private let settingsWindowController = SettingsWindowController()
	
	init() {
		statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
		
		if let button = statusItem.button {
			button.image = NSImage(systemSymbolName: "scribble", accessibilityDescription: "Break Timer")
		}
		
		setupMenu()
		
		NotificationCenter.default.addObserver(
			forName: NSNotification.Name("UpdateStatusMenu"),
			object: nil,
			queue: .main
		) { [weak self] _ in
			self?.setupMenu()
		}
	}
	
	private func setupMenu() {
		let menu = NSMenu()
		
		menu.addItem(NSMenuItem(title: "Next Break: \(formatTimeRemaining())", action: nil, keyEquivalent: ""))
		menu.addItem(NSMenuItem.separator())
		
		let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openSettings), keyEquivalent: ",")
		settingsItem.target = self  // Set the target to self
		menu.addItem(settingsItem)
		
		menu.addItem(NSMenuItem.separator())
		menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
		
		statusItem.menu = menu
	}
	
	private func formatTimeRemaining() -> String {
		let nextBreak = BreakManager.shared.nextBreakTime
		let interval = nextBreak.timeIntervalSince(Date())
		let minutes = Int(interval / 60)
		return "\(minutes) minutes"
	}
	
	@objc private func openSettings() {
		settingsWindowController.showWindow()
	}
}

class SettingsWindowController: NSObject, NSWindowDelegate {
	private var settingsWindow: NSWindow?
	
	func showWindow() {
		if settingsWindow == nil {
			let window = NSWindow(
				contentRect: NSRect(x: 0, y: 0, width: 300, height: 200),
				styleMask: [.titled, .closable],
				backing: .buffered,
				defer: false
			)
			
			window.center()
			window.title = "Settings"
			window.delegate = self
			window.contentView = NSHostingView(
				rootView: SettingsView()
					.environmentObject(BreakManager.shared)
			)
			
			settingsWindow = window
		}
		
		settingsWindow?.makeKeyAndOrderFront(nil)
		NSApp.activate(ignoringOtherApps: true)
	}
	func windowWillClose(_ notification: Notification) {
		// Don't set to nil, just let it persist
		// settingsWindow = nil
	}

}
