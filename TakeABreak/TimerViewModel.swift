
import SwiftUI
import UserNotifications

class BreakManager: ObservableObject, Equatable {
	
	static let shared = BreakManager()

    static func == (lhs: BreakManager, rhs: BreakManager) -> Bool {
        return lhs.breakInterval == rhs.breakInterval &&
               lhs.breakDuration == rhs.breakDuration &&
               lhs.nextBreakTime == rhs.nextBreakTime
    }
    
	@Published var breakInterval: TimeInterval
	@Published var breakDuration: TimeInterval
	@Published private(set) var nextBreakTime: Date
	private var breakWindowController: BreakWindowController?
	private var timer: Timer?
	
	init() {
		self.breakInterval = 6 // Default 10 seconds for testing
		self.breakDuration = 3 // Default 5 seconds for testing
		self.nextBreakTime = Date().addingTimeInterval(10)
		
		DispatchQueue.main.async { [weak self] in
			self?.startTimer()
		}
		
		requestNotificationPermission()
	}
	
	func startTimer() {
		timer?.invalidate()
		nextBreakTime = Date().addingTimeInterval(breakInterval)
		
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
			guard let self = self else { return }
			if Date() >= self.nextBreakTime {
				self.showBreakWindow()
				self.timer?.invalidate()
			}
		}
	}
	
	func showBreakWindow() {
		guard breakWindowController == nil else { return }
		breakWindowController = BreakWindowController(
			dismissAction: { [weak self] in
				self?.closeBreakWindow()
			},
			breakDuration: self.breakDuration,
			didDismiss: { [weak self] in
				self?.nextBreakTime = Date().addingTimeInterval(self?.breakInterval ?? 0)
				self?.startTimer()
			}
		)
		breakWindowController?.showBreakWindow()
	}
	
	func closeBreakWindow() {
		breakWindowController?.closeWindow()
		breakWindowController = nil
	}
	
	private func requestNotificationPermission() {
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
			print("Notification permission granted: \(granted)")
		}
	}
}

class BreakWindowController: NSWindowController {
	let dismissAction: () -> Void
	let breakDuration: TimeInterval
	let didDismiss: () -> Void
	private var autoDismissTimer: Timer?
	
	init(dismissAction: @escaping () -> Void, breakDuration: TimeInterval, didDismiss: @escaping () -> Void) {
		self.dismissAction = dismissAction
		self.breakDuration = breakDuration
		self.didDismiss = didDismiss
		super.init(window: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func showBreakWindow() {
		guard window == nil else { return }
		if let screenFrame = NSScreen.main?.frame {
			
			let window = NSWindow(
				contentRect: screenFrame,
				styleMask: [.fullSizeContentView, .nonactivatingPanel],
				backing: .buffered,
				defer: false
			)
			
			window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.mainMenuWindow)) + 2)
			window.backgroundColor = .black
			window.isOpaque = false
			window.hasShadow = false
			window.titlebarAppearsTransparent = true
			window.titleVisibility = .hidden
			window.collectionBehavior = [.canJoinAllSpaces,
										 .fullScreenPrimary,
										 .stationary,
			] // Prevents window from sliding away
			
			window.isMovableByWindowBackground = false
			window.isMovable = false
			
			NSApp.setActivationPolicy(.accessory)
			
			window.setFrame(screenFrame, display: true) // Ensures it matches fullscreen size
			window.makeKeyAndOrderFront(nil) // Brings the window to the foreground
			let breakView = BreakView(dismissAction: dismissAction, breakDuration: breakDuration)
			window.contentView = NSHostingView(rootView: breakView)
			self.window = window
			window.isReleasedWhenClosed = false
			window.setIsVisible(true)
			window.orderFrontRegardless()
			
			// Force window to front
			window.orderFrontRegardless()
			
			autoDismissTimer = Timer.scheduledTimer(withTimeInterval: breakDuration, repeats: false) { [weak self] _ in
				self?.closeWindow()
			}			
			
		}
	}
	
	
	func closeWindow() {
		autoDismissTimer?.invalidate()
		autoDismissTimer = nil
		window?.close()
		didDismiss()
	}
}
