import SwiftUI
import SceneKit
import Lottie

struct ContentView : View {
    var body: some View {
        ZStack{
            FinalView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FinalView : View {
    @State var splashScreen  = true
    var body: some View {
        ZStack{
            Group{
                if splashScreen {
                    SplashScreen()
                } else {
                    MainView()
                }
            }.onAppear {
                DispatchQueue
                    .main
                    .asyncAfter(deadline:
                    .now() + 4) {
                        splashScreen = false
                    }
            }
        }
    }
}

struct MainView: View {
    
    @State private var autoRotate3D = false
    @State private var offsetValue = false
    
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            manualRotate3D()
                .offset(x: offsetValue ? 0 : 400, y: -150)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.5).repeatCount(1)) {
                        offsetValue.toggle()
                    }
                }
            if autoRotate3D{
            AutoRotate3D()
                .offset(x: 0, y: -150)
            }
            
            ZStack{
                Toggle(isOn: $autoRotate3D, label: {
                    Image(systemName: "view.3d")
                        .resizable()
                        .frame(width: 40, height: 25)
                        .foregroundColor(.white)
                    Text(" R O T A T E")
                        .font(.title2)
                        .foregroundColor(.white)
                }).toggleStyle(SwitchToggleStyle(tint: .green))
            }
            .padding(30)
            .offset(x: 0, y: 35)
            
            ImageStack()
                .offset(x: 0, y: 300)
            
            Text("iMtRo ipsum dolor sit amet, consectetur adipiscing elit. Maecenas magna velit, lobortis vel dui in, ornare.")
                .font(.title2)
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .opacity(0.4)
                .padding()
                .offset(x: 0, y: 130)
            
            TitleSection()
                .offset(x: 0, y: -380)
        }
    }
}

struct ImageStack: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                CustomImage(imageNew: "2")
                CustomImage(imageNew: "1")
                CustomImage(imageNew: "3")
                CustomImage(imageNew: "4")
            }.padding(20)
        }
    }
}

struct CustomImage : View {
    @State var imageNew = "1"
    var body: some View {
        ZStack{
            Image(imageNew)
                .resizable()
                .frame(width: 150, height: 150)
                .overlay {RoundedRectangle(cornerRadius: 8).stroke(.white.opacity(0.2), lineWidth: 3)}
        }
    }
}
struct TitleSection: View {
    @State private var heartTap = false
    var body: some View {
        HStack{
            Text("i M t R o")
                .fontWeight(.black)
                .font(.largeTitle)
                .foregroundColor(.white)
            
            Spacer().frame(width: 15, height: 10)
            
            Text("D R O N E")
                .font(.title3)
                .foregroundColor(.white)
            
            Spacer().frame(width: 90, height: 0)
            
            ZStack{
                Image(systemName: heartTap ? "heart.fill" : "heart")
                    .resizable()
                    .frame(width: 30, height: 28)
                    .foregroundColor( heartTap ? Color.red : Color.white )
                    .onTapGesture {
                        heartTap.toggle()
                    }
            }
        }.padding()
    }
}

// Splash Screen dron Animation
struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image("city")
                .resizable()
                .frame(width: 400, height: 400)
                .offset(x: 0, y: 300)
                .opacity(0.4)
            
            LottieView(filename: "drone")
                .opacity(0.7)
                .frame(maxWidth: 500, maxHeight: 500)
                .offset(x: -30, y: -130)
            
            ZStack(alignment: .bottomTrailing){
                Text("i  M  t  R  o")
                    .font(.system(size: 60.0))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                Text("D R O N E")
                    .font(.system(size: 30.0))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}
