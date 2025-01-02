import Foundation

struct Settings: Codable {
    var focusTime: TimeInterval = 25 * 60 // 25 minutes default
    var shortBreakDuration: TimeInterval = 5 * 60 // 5 minutes default
    var longBreakDuration: TimeInterval = 15 * 60 // 15 minutes default
    var longBreakInterval: Int = 4 // After 4 short breaks
    var preBreakNotification: Bool = true
    var preBreakNotificationTime: TimeInterval = 10 // 10 seconds before break
    var screenBlur: Bool = true
    var blurIntensity: Double = 0.5
    var soundEffects: Bool = true
    var launchAtLogin: Bool = false
}
