import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.0
    
    var body: some View {
        
        if isActive {
            ContentView()
        } else {
            VStack {
                Image("onism SplashScreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300) // Set custom width and height
                    .opacity(opacity)
                    .onAppear {
                        // Animate the opacity and size of the image
                        withAnimation(.easeIn(duration: 1.5)) {
                            self.opacity = 1.0
                            self.size = 0.9
                        }
                        
                        // After 3 seconds, set isActive to true to show ContentView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                self.isActive = true
                            }
                        }
                    }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
