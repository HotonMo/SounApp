import SwiftUI
import CoreData

struct FoldersView: View {
    @State private var isEditing = false
    @Environment(\.managedObjectContext) private var viewContext
    //  @Environment(\.presentationMode) var presentationMode
    @State private var FoldernameInput: String = ""

    @Binding var ThefolderName :String
    
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FolderEntity.folderName, ascending: true)],
        animation: .default)
    private var Folders : FetchedResults<FolderEntity>
    
    @State private var isShowingAddFolderView = false

    
    var body: some View {
        
        
        
        NavigationView {
            ZStack{
                Image("Background1")
                    .renderingMode(.original)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: items, spacing: 10){
                        
                        AddFolderView(isShowingAddFolderView: $isShowingAddFolderView)
                        ForEach(Folders) { folder in
                            VStack {
                                
                                if isEditing {
                                    
                                    Button {
                                        withAnimation {
                                            let index = Folders.firstIndex(of: folder)!
                                            Folders.map{_ in Folders[index]}.forEach(viewContext.delete)
                                            
                                            do {
                                                try viewContext.save()
                                            } catch {
                                                let nsError = error as NSError
                                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "x.circle.fill")
                                            .resizable()
                                            .frame(width: 30.0, height: 30.0)
                                            .foregroundColor(Color.red)
                                    } //    .offset(x: 70, y: -75)
                                }
                                    FolderView(name: folder.folderName ?? "None")
                                
                           
                                
                            }
                            
                            
                        }
                    }
                    
                }
            }
            .navigationTitle("Folders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation { isEditing.toggle() }
                    }
                }
                
                
                
            }
            
            
        }  .alert("Add New Folder", isPresented: $isShowingAddFolderView, actions: {
            TextField("Folder Name", text: $FoldernameInput)
            
            Button("Add", action: {
                addFContact(name: FoldernameInput)
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter the folder name ")
            
        })
        
        
    }
    
    

    
    private func addFContact(name: String) {
        let newFolder = FolderEntity(context: viewContext)
        newFolder.folderName = name
        
        
        do {
            try viewContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    
    
    struct FolderView : View{
        @State var isPresented = false
        let name : String
        var body: some View{
            Button{ isPresented.toggle()}label: {
            VStack{
               
                ZStack{
                    Image("BlueFile")
                    
                        .frame(width: 150.0, height: 150.0)
                        .background(Color("lightBlue3"))
                        .cornerRadius(17)
                }
                        Text(name)
                            .font(.system(size: 18))
                        
                   
                }.fullScreenCover(isPresented: $isPresented, content: {
                    Catgpage(ThefolderName: name, CatgName: Binding<String>.constant("File") )
                    
                })
            }
        }
        
    }
    
    
    
    
    
    
    
    struct AddFolderView : View{
        @Binding var isShowingAddFolderView : Bool
        var body : some View{
            
            Button(action: { isShowingAddFolderView = true }){
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
        
    }
    struct FoldersView_Previews: PreviewProvider {
        static var previews: some View {
            FoldersView(ThefolderName: Binding<String>.constant("Casper")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
        
        
    }
    
    
    
    
    
    
}

