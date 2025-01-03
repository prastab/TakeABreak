import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    var breakManager: BreakManager?
    var settingsWindow: NSWindow?
    
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "scribble", accessibilityDescription: "Break Timer")
        }
        
        setupMenu()
        createSettingsMenu()
    }
    
    private func setupMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Next Break: \(formatTimeRemaining())", action: nil, keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        
        let settingsItem = NSMenuItem(title: "Settings...", action: #selector(openSettingsWindow), keyEquivalent: ",")
        menu.addItem(settingsItem)
        
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    private func formatTimeRemaining() -> String {
        guard let nextBreak = breakManager?.nextBreakTime else { return "N/A" }
        let interval = nextBreak.timeIntervalSince(Date())
        let minutes = Int(interval / 60)
        return "\(minutes) minutes"
    }
    
    func createSettingsMenu() {
        let mainMenu = NSMenu()
        let appMenuItem = NSMenuItem()
        mainMenu.addItem(appMenuItem)
        NSApplication.shared.mainMenu = mainMenu
        
        let appMenu = NSMenu()
        appMenuItem.submenu = appMenu
        
        let settingsMenuItem = NSMenuItem(title: "Settings...", action: #selector(openSettingsWindow), keyEquivalent: ",")
        appMenu.addItem(settingsMenuItem)
    }
    
    @objc func openSettingsWindow() {
        if settingsWindow == nil {
            settingsWindow = NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered,
                defer: false
            )
            settingsWindow?.center()
            
            let breakManager = BreakManager()
            settingsWindow?.contentView = NSHostingView(rootView: SettingsView().environmentObject(breakManager))
        }
        settingsWindow?.makeKeyAndOrderFront(nil)
    }
}

struct SettingsLinkView: View {
    var body: some View {
        SettingsLink {
        }
        .frame(width: 100)
    }
}
