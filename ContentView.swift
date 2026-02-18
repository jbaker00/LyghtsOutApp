import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SignupView()
                .navigationTitle("LyghtsOut Lacrosse")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
