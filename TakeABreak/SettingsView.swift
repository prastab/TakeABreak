import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var breakManager: BreakManager
    
    var body: some View {
        Form {
            Section(header: Text("Break Settings")) {
                Picker("Break Interval", selection: $breakManager.breakInterval) {
					Text("1 minutes").tag(TimeInterval(60))
                    Text("30 minutes").tag(TimeInterval(1800))
                    Text("1 hour").tag(TimeInterval(3600))
                    Text("2 hours").tag(TimeInterval(7200))
                }
                .onChange(of: breakManager.breakInterval) { _ in
                    breakManager.startTimer()
                }
                
                Picker("Break Duration", selection: $breakManager.breakDuration) {
                    Text("15 seconds").tag(TimeInterval(15))
                    Text("30 seconds").tag(TimeInterval(30))
                    Text("1 minute").tag(TimeInterval(60))
                }
            }
        }
        .padding()
        .frame(width: 300)
    }
}
