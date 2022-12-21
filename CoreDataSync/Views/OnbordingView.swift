//
//  ContentView.swift
//  onbording11
//
//  Created by eman alejilah on 25/05/1444 AH.
//

import SwiftUI


struct OnBoardingStep{
    let image: String
    let title: String
    let description: String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "Image1 1", title: "Access to medical files", description: "reach Your categorized medical history in an easy and fast way"),
    OnBoardingStep(image: "Image2", title: "Family health history", description:"you can add your family profiles, take care of all their needs, and keep track of their health recordes"),
    OnBoardingStep(image: "Image3", title: " Medical Journal", description: "Keep all your helath data at one plase and save them " ),
    
    
]

struct OnbordingView: View {
    @State private var currentStep = 0
    
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Spacer()
                    //     if   !(self.currentStep == onBoardingSteps.count - 1) {
                    //                    Button(action: {
                    //                        FolderPageView(
                    //                            currentUser: userList[0]
                    //                        )
                    //                        self.currentStep = onBoardingSteps.count - 1
                    //                    }){
                    //
                    //                        Text("Skip")
                    //                            .padding(16)
                    //                            .foregroundColor(Color("Color1"))
                    //                        //   }
                    //                    }
                }
                TabView(selection: $currentStep){
                    ForEach (0..<onBoardingSteps.count, id: \.self) {it in
                        VStack{
                            Image(onBoardingSteps[it].image)
                                .resizable()
                                .frame(width: 300, height: 300)
                            Text(onBoardingSteps[it].title)
                            //                            .font(.title)
                                .font(.system(size: 27))
                                .bold()
                                .foregroundColor(Color("Color1"))
                                .padding(10)
                            Text(onBoardingSteps[it].description)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 8)
                                .foregroundColor(Color("Color2"))
                                .font(.system(size: 23))
                        }
                        .tag(it)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack{
                    ForEach (0..<onBoardingSteps.count, id: \.self) { it in
                        if it == currentStep{
                            Circle()
                                .frame(width: 12, height:12 )
                                .cornerRadius(20)
                                .foregroundColor(Color("Color1"))
                        } else {
                            Circle()
                                .frame(width: 12, height: 12)
                                .foregroundColor(Color("Color2"))
                        }
                    }
                }
                .padding(.bottom, 40)
                
                
                Button(action: {
                    if self.currentStep < onBoardingSteps.count-1{
                        self.currentStep += 1
                    }else{
                        
                    }
                }){
                    Text(currentStep < onBoardingSteps.count-1 ? "Next" : "Start Now")
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color("Color1"))
                        .cornerRadius(16)
                        .padding(.horizontal, 50)
                        .foregroundColor(.white)
                        .padding(.bottom, 70)
                    
                }
                .buttonStyle(PlainButtonStyle())
            }
            .toolbar {
          NavigationLink(destination:   FolderPageView(
            currentUser: userList[0]), label:
                            {
              Text("skip")
                  .foregroundColor(.blue)
          }
                    
                
            
            
                        ) }
                         }
                         }
//FolderPageView(
//  currentUser: userList[0])

struct OnbordingView_Previews: PreviewProvider {
    static var previews: some View {
        OnbordingView()
    }
}





          }
