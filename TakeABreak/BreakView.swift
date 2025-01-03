import SwiftUI
struct BreakView: View {
	let dismissAction: () -> Void
	let breakDuration: TimeInterval

	var body: some View {
		ZStack {
			VisualEffectView()
			Color.clear
				.modifier(CustomBlurEffect())

			VStack(spacing: 20) {
				Text("Time for a Break!")
					.font(.system(size: 48, weight: .bold))
					.foregroundColor(.white)

				Text("Look away from your screen")
					.font(.title2)
					.foregroundColor(.white)

				Button("Skip Break") {
					dismissAction()
				}
				.padding()
				.background(Color.white.opacity(0.2))
				.foregroundColor(.white)
				.cornerRadius(10)
			}
		}
		.edgesIgnoringSafeArea(.all)
		.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + breakDuration) {
				dismissAction()
			}
		}
	}
}

struct CustomBlurEffect: ViewModifier {
	func body(content: Content) -> some View {
		content
			.blur(radius: 25)
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
