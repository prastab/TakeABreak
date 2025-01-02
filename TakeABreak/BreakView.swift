import SwiftUI

struct BreakView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Text("Break Time!")
            .font(.largeTitle)
            .onAppear {
                maximizeWindow()
            }
    }
    
    private func maximizeWindow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let window = NSApplication.shared.windows.first {
                // Get the main screen's frame
                if let screen = NSScreen.main {
                    let screenFrame = screen.frame
                    window.isOpaque = false
                    window.alphaValue = 0.95
                    
                    // Set window frame to match screen
                    window.setFrame(screenFrame, display: true, animate: true)
                    
                    // Ensure window takes up full screen
                    window.minSize = screenFrame.size
                    window.maxSize = screenFrame.size
                    
                    // Remove ability to resize
                    window.styleMask.remove(.resizable)
                    window.styleMask.remove(.miniaturizable)
                    window.styleMask.remove(.titled)
                    
                    window.makeKeyAndOrderFront(nil)
                    print("Break window maximized and brought to front")
                    
                }
            }
        }
    }
}
