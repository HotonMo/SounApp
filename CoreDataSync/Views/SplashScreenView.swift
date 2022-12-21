//
//  SplashScreenView.swift
//  onbording11
//
//  Created by eman alejilah on 25/05/1444 AH.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if  isActive {
            OnbordingView()
        }else{
            ZStack(alignment: .center){
                Image("background0")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        Image("logo22")
                        Text("Soun")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
        }
       
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
     
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
