//
//  ContentView.swift
//  Soun
//
//  Created by Hajar on 13/05/1444 AH.
//

import SwiftUI

struct FolderPageView: View {
    
    
    @State private var presentAlert = false
    @State private var folderName: String = ""
    @State var currentUser : User
    let items = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
             //   VStack{
                    ScrollView(.vertical){
                        LazyVGrid(columns: items, spacing: 10){
                            Button(action: {
                                presentAlert = true
                            }){
                                AddFolderView()
                            }.alert("Add New Folder", isPresented: $presentAlert, actions: {
                                TextField("Folder Name", text: $folderName)
                                
                                Button("Add", action: {currentUser.folders.append(Folder(name: folderName))})
                                Button("Cancel", role: .cancel, action: {})
                            }, message: {
                                Text("Please enter the folder name ")
                            })
                            ForEach(currentUser.folders, id: \.id) { folder in
                                FolderView(name:  folder.name)
                                    .overlay(
                                        DeleteButton(currentlyOn: folder, theList: currentUser.folders, onDelete: removeRows)
                                        , alignment: .topTrailing)
                            }.onDelete(perform: removeRows)
                        }
                        .padding(.top, 180)
                    }
             //   }
                
                
                
            }
            .navigationTitle("All Folders")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    EditButton()
                        .padding()
                }
            }
        }
        
    }
    func removeRows(at offsets: IndexSet) {
        withAnimation {
            currentUser.folders.remove(atOffsets: offsets)
        }
    }
}





struct FolderView : View{
    let name : String
    var body: some View{
        VStack{
            ZStack{
                Image("BlueFile")
            }
            .frame(width: 150.0, height: 150.0)
            .background(Color("lightBlue3"))
            .cornerRadius(17)
            Text(name)
                .font(.system(size: 18))
        }
    }
}





struct AddFolderView : View{
    var body: some View {
        VStack{
            ZStack{
                Image("GrayFile")
                    .padding(.leading, 5)
            }
            .frame(width: 150.0, height: 150.0)
            .background(Color("lightBlue3").opacity(0.4))
            .cornerRadius(17)
            .overlay(
                RoundedRectangle(cornerRadius: 17)
                    .stroke(.gray, style: StrokeStyle(lineWidth: 1, dash: [13, 5]))
            )
            Text("Add")
                .font(.system(size: 18))
                .foregroundColor(Color.blue)
        }
    }
}








struct DeleteButton<T>: View where T: Equatable {
  @Environment(\.editMode) var editMode

  let currentlyOn: T
  var theList: [T]
  let onDelete: (IndexSet) -> ()

  var body: some View {
    VStack {
        if self.editMode?.wrappedValue == .active {
            Button(action: {
                if let index = theList.firstIndex(of: currentlyOn) {
                    self.onDelete(IndexSet(integer: index))
                }
            }) {
                Image(systemName: "minus.circle")
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
            }
            .offset(x: 12, y: -15)
        }
    }
  }
}









struct FolderPageView_Previews: PreviewProvider {
    static var previews: some View {
        FolderPageView(
            currentUser: userList[0]
        )
    }
}





