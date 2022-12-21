//
//  Catgpage.swift
//  CoreDataSync
//
//  Created by hoton on 27/05/1444 AH.
//


import SwiftUI

struct MenuModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("LGreen"))
            .padding(.horizontal)
        
        
            .foregroundColor(Color.black)
            .font(Font.system(size: 20))
    }
}



struct Catgpage: View {
    @State var folderName = "Casper"
    @State var showDetails = false
    @State var isEditing = false
    @State private var Expand = true
    @State var Hospitals = "All Hospitals"
    let TheHospitals:[String] = ["Rabieh Medical Hospital", "Salman Habib Hospital", "King Faisal Specialist Hospital and Research Center", "King Abdulaziz City - National Guard Health Affairs", "Prince Sultan Medical City", "Saudi Center for Organ Transplantation", "Security forces Hospital", "Prince Salman bin Abdulaziz Hospital", "Green Crescent Hospital", "Shaqra General Hospital", "King Khaled Eye Specialist Hospital", "Al-Iman General Hospital", "Saudi British Hospital", "Prince Salman Center for Kidney Diseases", "Al Jazeera Hospital", "Dallah Hospital", "Dermatology and plastic surgery hospital", "Kingdom Hospital", "National Hospital", "Mowasat Hospital", "Military Forces Hospital", "King Abdulaziz University Hospital", "German Saudi Hospital", "King Saud Medical City"]

    var body: some View {
        NavigationView(){
            
            ZStack{
                Image("Image s")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack{
                    HStack{
                        ////                        NavigationLink(destination: BlankPage()){
                        ////                            Image(systemName: "folder.circle.fill")
                        ////                                .resizable()
                        ////                                .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                        ////                                .frame(width: 50, height: 58)
                        ////                        }
                        Text("\(folderName)'s folder")
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.0, green: 0.0, blue: 0.0)/*@END_MENU_TOKEN@*/)
                            .lineLimit(0)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding(.leading)
                        Spacer()
                    }.padding()
                    
                    Menu {
                        ForEach(TheHospitals, id: \.self){ neighbor
                            in
                            Button(action: { Hospitals = neighbor}, label: {Text(neighbor)})
                        }
                    }label: {Title:  do {
                        
                        ZStack{
                            Image(systemName: "rectangle.fill")
                                .resizable()
                                .frame(width: 335, height: 53, alignment: .center)
                                .foregroundColor(Color(red: 0.904, green: 0.934, blue: 0.96))
                            
                            Text(Hospitals)
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: Expand ? "chevron.down" : "chevron.up")
                                .frame(width: 19.0, height: 21.0)
                                .foregroundColor(.black)
                                .padding(.leading, 270)
                        }
                    }}.modifier(MenuModifier())
                    
                    
                    
                    HStack(spacing: 20) {
                        Button {
                            print("tapped")
                        } label: {
                            NavigationLink(destination: ContentView()) {
                                ZStack {
                                    Image(systemName: "rectangle.portrait.fill")
                                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                        .frame(width: 164.0, height: 176.0)
                                        .foregroundColor(Color(red: 0.888, green: 0.943, blue: 0.976))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.cyan, lineWidth: 1))
                                     .border(.cyan)
                                    
                                    VStack{
                                        Image(systemName: "pills")
                                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                            .fontWeight(.medium)
                                            .frame(width: 64, height: 58)
                                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                        Text("Medicine")
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                            .frame(width: 96,height: 29)
                                    }
                                }
                                
                            }
                        }
                        Button{
                            print("tapped")
                        } label: {
                            NavigationLink(destination: ContentView(), label: {
                                ZStack{
                                    Image(systemName: "rectangle.portrait.fill")
                                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                        .frame(width: 164.0, height: 176.0)
                                        .foregroundColor(Color(red: 0.888, green: 0.943, blue: 0.976))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.cyan, lineWidth: 1))
                                    // .border(.cyan)
                                    VStack{
                                        Image("Image s2")
                                        Text("Reports")
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                            .frame(width: 84,height: 29.0)
                                    }
                                }})
                        }
                        
                    }.padding(10)
                    
                    HStack(spacing: 20){
                        Button {
                            print("tapped")
                        } label: {
                            NavigationLink(destination: ContentView(), label: {
                                ZStack{
                                    Image(systemName: "rectangle.portrait.fill")
                                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                                        .frame(width: 164.0, height: 176.0)
                                        .foregroundColor(Color(red: 0.888, green: 0.943, blue: 0.976))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.cyan, lineWidth: 1))
                                    // .border(.cyan)
                                    
                                    VStack{
                                        Image(systemName: "syringe")
                                            .resizable()
                                            .frame(width: 64, height: 58)
                                            .foregroundColor(Color(red: 0.071, green: 0.589, blue: 0.887))
                                        Text("Lab Results")
                                            .fontWeight(.medium)
                                            .frame(width: 96,height: 29)
                                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                    }
                                }})
                        }
                        Button {
                            print("tapped")
                        } label: {
                            NavigationLink(destination: ContentView(), label: {
                                ZStack{
                                    Image(systemName: "rectangle.portrait.fill")
                                        .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                        .frame(width: 164.0, height: 176.0)
                                        .foregroundColor(Color(red: 0.888, green: 0.943, blue: 0.976))
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.cyan, lineWidth: 1))
                                    // .border(.cyan)
                                    VStack{
                                        Image("Image s3")
                                        Text("X-ray")
                                            .fontWeight(.medium)
                                            .frame(width: 54.0,height: 29)
                                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                    }
                                }}) }
                    }
                    
                }.padding(.bottom, 60)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        print("Done Tapd")
                    } label: { NavigationLink(destination: ContentView(), label: {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                            .frame(width: 41, height: 44)
                    }) //Why we wrote ")" here?
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        print("Done")
                    } label: {
                        NavigationLink(destination: ContentView(), label: {
                            Image(systemName: "chevron.backward.circle")
                                .resizable()
                                .foregroundColor(Color(red: 0.072, green: 0.589, blue: 0.887))
                                .frame(width: 41, height: 44)
                        })
                    }
                }
            }
            //   .navigationTitle("\(folderName)'s Folder")
            
            // NavigationBarItem(
        }
    }
    
    struct Catgpage_Previews: PreviewProvider {
        static var previews: some View {
            Catgpage()
        }
    }
}
