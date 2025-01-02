import Foundation
import Combine

class TimerViewModel: ObservableObject {
    @Published var timerState: TimerState = .idle
    @Published var focusTime: TimeInterval = 5 * 1 // 25 minutes default
    @Published var shortBreakDuration: TimeInterval = 5 * 60 // 5 minutes default
    @Published var longBreakDuration: TimeInterval = 15 * 60 // 15 minutes default
    @Published var longBreakInterval: Int = 4 // After 4 short breaks
    @Published var timeRemaining: TimeInterval = 0
    @Published var settings: Settings = Settings()
    
    private var currentTimer: AnyCancellable?
    private var shortBreaksTaken: Int = 0
    @Published var isBreakWindowPresented: Bool = false
    
    enum TimerState {
        case idle, focus, shortBreak, longBreak
    }
    
    func startTimer() {
        if timerState == .idle {
            timerState = .focus
            timeRemaining = focusTime
            startCountdown()
        }
    }
    
    func pauseTimer() {
        currentTimer?.cancel()
        currentTimer = nil
    }
    
    func resetTimer() {
        pauseTimer()
        timerState = .idle
        timeRemaining = 0
        shortBreaksTaken = 0
        isBreakWindowPresented = false
    }
    
    func skipBreak() {
        pauseTimer()
        endBreak()
    }
    
    private func startCountdown() {
        currentTimer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.endFocus()
                }
            }
    }
    
    private func endFocus() {
        pauseTimer()
        if shortBreaksTaken + 1 >= longBreakInterval {
            startLongBreak()
        } else {
            startShortBreak()
        }
    }
    
    private func startShortBreak() {
        timerState = .shortBreak
        timeRemaining = shortBreakDuration
        shortBreaksTaken += 1
        isBreakWindowPresented = true
        
        startCountdown()
    }
    
    private func startLongBreak() {
        timerState = .longBreak
        timeRemaining = longBreakDuration
        shortBreaksTaken = 0
        isBreakWindowPresented = true
        startCountdown()
    }
    
    private func endBreak() {
        timerState = .idle
        timeRemaining = 0
        isBreakWindowPresented = false
    }
    
    func loadSettings() {
        if let data = UserDefaults.standard.data(forKey: "settings") {
            if let decodedSettings = try? JSONDecoder().decode(Settings.self, from: data) {
                self.settings = decodedSettings
                self.focusTime = decodedSettings.focusTime
                self.shortBreakDuration = decodedSettings.shortBreakDuration
                self.longBreakDuration = decodedSettings.longBreakDuration
                self.longBreakInterval = decodedSettings.longBreakInterval
            }
        }
    }
    
    func saveSettings() {
        if let encoded = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(encoded, forKey: "settings")
        }
    }
}
