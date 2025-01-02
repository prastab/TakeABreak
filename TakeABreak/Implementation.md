
**Project Details**

*   **Project Name:** Cooldown
*   **Developer:** \[Your Name/Team Name]
*   **Programming Language:** Swift
*   **UI Framework:** SwiftUI
*   **Target Platform:** macOS
*   **Development Tools:** Xcode, Git (or other version control)
*   **Project Goal:** To create a smart break reminder app for macOS that helps users reduce eye strain, computer vision syndrome (CVS), and digital fatigue while improving productivity.

**App Description**

Cooldown is a macOS menu bar application designed to promote healthy screen habits and enhance user well-being. It intelligently monitors user activity and gently encourages regular breaks to minimize eye strain, prevent computer vision syndrome (CVS), and combat digital fatigue. Unlike obtrusive break reminder apps, Cooldown works discreetly in the background, respecting the user's workflow and providing timely nudges only when necessary.

**Core Features (Prioritized)**

1. **Smart Timer:** Tracks active work time and initiates breaks based on user-defined focus intervals.
2. **Configurable Settings:** A dedicated UI to personalize focus time, short and long break durations, and other preferences.
3. **Unobtrusive Reminders:** Gentle pre-break notifications to allow users to wrap up tasks.
4. **Screen Blurring (Cooldown):** Subtly blurs the entire screen content during breaks.
5. **Idle Time Detection:** Pauses or resets the timer when the user is inactive.
6. **Keyboard Shortcuts:** Essential shortcuts to quickly start, skip, or delay breaks.
7. **Menu Bar Integration:** A discreet menu bar icon for status and quick access to settings.
8. **Multiple Screen Support:** Handles multiple display setups.
9. **Native macOS Design:** Integrates seamlessly with the macOS aesthetic.
10. **Sound Effects:** A soft chime to signal the end of a break.

**Detailed Features (Prioritized)**

1. **Timer Management**
    *   **Focus Time:** User-configurable duration for focused work sessions.
    *   **Short Breaks:** Frequent, brief breaks for resting the eyes.
    *   **Long Breaks:** Occasional longer breaks for physical and mental relaxation.
    *   **Long Break Interval:** The number of short breaks before a long break is triggered.
    *   **Timer Controls:** Start, pause, reset, and skip functionality.

2. **Break Experience**
    *   **Pre-Break Notifications:** Gentle notifications displayed before a break.
    *   **Screen Blurring (Cooldown):** Applies a configurable blur effect during breaks.
    *   **Automatic Break Termination:** Breaks end automatically after the set duration.
    *   **Manual Break Termination:** Users can manually end breaks early.

3. **User Interface**
    *   **Menu Bar App:**
        *   Status icon indicating the timer's state.
        *   Menu with quick actions (Start Break, Skip Break, Settings).
    *   **Settings Window:**
        *   Clear display of timer status.
        *   User-friendly controls for adjusting all settings.

4. **Customization**
    *   **Timer Durations:** Focus time, short break duration, long break duration, long break interval.
    *   **Notification Preferences:** Enable/disable pre-break notifications, adjust timing.
    *   **Cooldown (Blur):** Enable/disable screen blurring, adjust blur intensity.
    *   **Sound Effects:** Enable/disable sound effects.
    *   **Keyboard Shortcuts:** Customize or disable essential keyboard shortcuts.
    *   **Launch at Login:** Option to start Cooldown automatically on login.

5. **Integrations**
    *   **Keyboard Shortcuts:** Support for essential keyboard shortcuts.
    *   **Sound Effects:** Customizable sound cues for break start/end.
    *   **Menu Bar:** Integration with the macOS menu bar.

6. **Advanced**
    *   **Multiple Screen Support:** Applies screen blurring to all connected displays.
    *   **Native Design:** Adheres to macOS Human Interface Guidelines.
    *   **Dark Mode Support:** Adapts to the system-wide appearance setting.
    *   **Accessibility:** Designed to be accessible (VoiceOver compatibility, keyboard navigation).

**Deferred Features (Next Steps)**

1. **Contextual Awareness**
    *   **Meeting/Call Detection:**
        *   **Possible Methods:** Microphone activity monitoring, AppleScript/Accessibility API, calendar integration.
        *   **Action:** Pause the timer during meetings/calls.
    *   **Video Playback Detection:**
        *   **Possible Methods:** Accessibility API, monitoring window titles, AVPlayer/AVKit.
        *   **Action:** Pause the timer during video playback.

**Implementation Plan**

**Phase 1: Project Setup and Core Timer Functionality**

*   **Step 1: Project Setup**
    *   Create a new macOS project in Xcode using SwiftUI.
    *   Set up Git for version control.
    *   Define project folder structure (Models, Views, ViewModels, Utilities).
    *   Adopt the MVVM design pattern.
*   **Step 2: Core Timer Logic**
    *   Create a `TimerViewModel` to manage timer state, focus time, break durations, and long break interval.
    *   Use `Timer.publish` or `DispatchSourceTimer` for the timer.
    *   Implement start, pause, reset, and skip functions.
    *   Differentiate between short and long breaks.
*   **Step 3: Basic Break Triggering**
    *   Trigger `startBreak` in `TimerViewModel` when the focus timer ends.
    *   Change app state to "break mode."
    *   Start a break timer.
    *   Trigger `endBreak` when the break timer ends.
*   **Step 4: Basic UI (Main Window)**
    *   Create a simple SwiftUI view for timer status (temporary, for testing).
    *   Add buttons for start, pause, reset, and skip (temporary).
    *   Bind UI elements to `TimerViewModel` properties.
*   **Step 5: Settings Storage**
    *   Use `UserDefaults` to store user settings.
    *   Create a `Settings` struct.
    *   Load settings on launch, save on change.

**Phase 2: UI and Settings**

*   **Step 6: Settings Window**
    *   Create a dedicated SwiftUI view for the settings window.
    *   Use `Form` or `List` to organize settings.
    *   Implement controls (sliders, toggles, text fields) for:
        *   Timer durations (focus, short break, long break, interval).
        *   Notification preferences (enable/disable, timing).
        *   Cooldown (enable/disable, blur intensity).
        *   Sound effects (enable/disable).
        *   Launch at Login.
    *   Bind settings UI elements to the `Settings` struct.
    *   Display the current timer status within the settings window.
*   **Step 7: Enhanced Main Window**
    *   Update the main window with a more polished UI, if needed for testing or to show basic information
*   **Step 8: Menu Bar App**
    *   Create an `NSStatusItem`.
    *   Create an `NSMenu` for quick actions (Start Break, Skip Break, Settings).
    *   Connect menu items to functions in `TimerViewModel` or a menu bar controller.
    *   Display timer status (e.g., time remaining or a visual indicator) in the menu bar icon or menu.

**Phase 3: Break Experience and Refinements**

*   **Step 9: Pre-Break Notifications**
    *   Add a timer for pre-break notifications.
    *   Use `NSUserNotification` or a custom system for the notification.
    *   Display a gentle notification before the break starts.
*   **Step 10: Screen Blurring (Cooldown)**
    *   **Challenge:** Non-intrusive full-screen blur.
    *   **Solutions:**
        *   `CIFilter` (`CIBlur`) on a full-screen window.
        *   Metal/Core Graphics for more control.
    *   Create/display the overlay on break start, remove on break end.
*   **Step 11: Idle Time Detection**
    *   Use `NSEvent.addGlobalMonitorForEvents` to monitor mouse/keyboard events.
    *   Create an `IdleDetector` class.
    *   Pause/reset the timer in `TimerViewModel` based on inactivity.
*   **Step 12: Sound Effects**
    *   Use `NSSound` for chimes (break end).
    *   Optional: Other sound effects (if desired).
    *   Connect sound settings to the settings UI.

**Phase 4: Integrations and Advanced Features**

*   **Step 13: Keyboard Shortcuts**
    *   Use `NSEvent.addLocalMonitorForEvents` or `addGlobalMonitorForEvents`.
    *   Define essential key combinations (Start Break, Skip Break, Delay Break).
    *   Trigger actions in `TimerViewModel`.
*   **Step 14: Multiple Screen Support**
    *   Use `NSScreen` to get display information.
    *   Create an overlay window for each screen.
    *   Adapt timer logic and UI.
*   **Step 15: Native Design**
    *   Review Apple's Human Interface Guidelines.
    *   Match macOS design.
    *   Support Dark Mode.

**Phase 5: Testing and Polishing**

*   **Step 16: Unit Testing**
    *   Write unit tests for core logic components.
*   **Step 17: UI Testing**
    *   Use Xcode's UI testing framework.
    *   Test various scenarios and edge cases.
*   **Step 18: Beta Testing**
    *   Distribute to beta testers.
    *   Collect feedback.
*   **Step 19: Bug Fixing and Refinement**
    *   Address bugs.
    *   Iterate on UI/UX based on feedback.
    *   Optimize performance.
*   **Step 20: Accessibility**
    *   Audit with accessibility tools.
    *   Test with VoiceOver.

**Phase 6: Release and Post-Release**

*   **Step 21: App Store Preparation**
    *   Create app icons, screenshots, and description.
    *   Fill in metadata.
    *   Comply with App Store Review Guidelines.
*   **Step 22: Release**
    *   Submit to the App Store.
    *   Address review feedback.
    *   Release the app!
*   **Step 23: Monitoring and Updates**
    *   Monitor reviews, crash reports, analytics.
    *   Plan for future updates (including the deferred Contextual Awareness features).

**Additional Considerations**

*   **Energy Consumption:** Optimize for low energy usage.
*   **Onboarding:** Consider a brief onboarding experience.
*   **Error Handling:** Implement robust error handling.
*   **Localization:** Plan for localization if targeting a global audience.
*   **Privacy:** Be transparent about data collection (if any).
*   **Marketing:** Develop a marketing strategy.


