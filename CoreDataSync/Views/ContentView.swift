//
//  ContentView.swift
//  CoreDataSync
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isEditing = false
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ContentEntity.time, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<ContentEntity>
    
    @State private var isShowingAddView = false
    @State  var CatgName = "Files"
    
    var body: some View {
        
        
        NavigationView {
            ZStack{
                Image("background")
                    .renderingMode(.original)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .ignoresSafeArea()
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: items, spacing: 10){
                        
                        AddFileView(isShowingAddView: $isShowingAddView)

                        ForEach(contacts) { contact in
                            VStack {
                                if let image = contact.photo {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 170, alignment: .center)
                                        .clipped()
                                        .padding(.horizontal)
                                        .padding(.top)
                                    
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 64, height: 64, alignment: .center)
                                        .foregroundColor(.gray)
                                    
                                }
                                if isEditing {
                                    
                                    Button {
                                        withAnimation {
                                            let index = contacts.firstIndex(of: contact)!
                                            contacts.map{_ in contacts[index]}.forEach(viewContext.delete)
                                            
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
                                Text(contact.name ?? "None")
                              //  Text(contact.time?.formatted(date: .complete, time: .omitted) ?? "No time")
                                Text(contact.time!, formatter: itemFormatter)
                            }
                            
                        }
                    }
                   
                }
            }
            .navigationBarTitle("My \(CatgName)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Done" : "Edit") {
                        withAnimation { isEditing.toggle() }
                    }
                }
            }
        }.sheet(isPresented: $isShowingAddView, content: {
            AddContactView(onAdd: { name, image in
                isShowingAddView = false
                addContact(name: name, photo: image)
            }, onCancel: { isShowingAddView = false })
        })
        
        
    }
    
    
    
    
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()

    
    private func addContact(name: String, photo: UIImage?) {
        let newContact = ContentEntity(context: viewContext)
        newContact.name = name
        newContact.photo = photo
        
        do {
            try viewContext.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }
    
    
    
    private func deleteContacts(offsets: IndexSet) {
        offsets.map { contacts[$0] }.forEach(viewContext.delete)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}




struct AddFileView : View{
    @Binding var isShowingAddView : Bool
    var body : some View{
        
        Button(action: { isShowingAddView = true }){
            ZStack{
                RoundedRectangle(cornerRadius: 6 )
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 4.0, lineCap: .round, dash: [10, 20]))
                    .frame(width: 150, height: 170)
                    .clipShape(Rectangle())
                    Image(systemName: "plus")
                    .resizable()
                    .frame(width: 20 , height: 20)
                
                
            }
        }
        
        
        
        
        
        
    }}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(CatgName: Binding<String>.constant("images")).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
//

