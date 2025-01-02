//
//  ContentView.swift
//  TakeABreak
//
//  Created by Prastab Ghimire on 1/1/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        ZStack {
            if timerViewModel.timerState == .shortBreak || timerViewModel.timerState == .longBreak {
                VisualEffectView()
                Color.clear
                    .modifier(CustomBlurEffect())
				VStack{
					Text("Break Time!")
						.font(.largeTitle)
						.frame(maxWidth: .infinity, maxHeight: .infinity)
						.background(.thickMaterial)
						.onAppear {
							maximizeWindow()
						}
						.onChange(of: scenePhase) { phase in
							if phase == .active {
								maximizeWindow()
							}
						}
					Button("Skip Break") {
						timerViewModel.skipBreak()
					}
				}
            } else {
                VStack {
                    Text("Time Remaining: \(Int(timerViewModel.timeRemaining))")
                    Text("Timer State: \(String(describing: timerViewModel.timerState))")
                    HStack {
                        Button("Start") {
                            timerViewModel.startTimer()
                        }
                        Button("Pause") {
                            timerViewModel.pauseTimer()
                        }
                        Button("Reset") {
                            timerViewModel.resetTimer()
                        }
                        Button("Skip") {
                            timerViewModel.skipBreak()
                        }
                    }
                }
                .padding()
            }
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
                    
                    
                }
            }
        }
    }
}

struct CustomBlurEffect: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 25)  // Higher blur radius
            .opacity(0.9)
    }
}

struct VisualEffectView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSVisualEffectView {
        let visualEffectView = NSVisualEffectView()
        visualEffectView.material = .fullScreenUI
        visualEffectView.blendingMode = .behindWindow
        visualEffectView.state = .active
        visualEffectView.wantsLayer = true
        return visualEffectView
    }
    
    func updateNSView(_ visualEffectView: NSVisualEffectView, context: Context) {
        visualEffectView.material = .fullScreenUI
    }
}
