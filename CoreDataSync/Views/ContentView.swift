//
//  ContentView.swift
//  CoreDataSync
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var isEditing = false
    var items1: [GridItem] = Array(repeating: .init(.fixed(1)), count: 2  )
   
    var items: [GridItem] {
      Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
        
    }
    
    


    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Contact.name, ascending: true)],
        animation: .default)
    private var contacts: FetchedResults<Contact>

    @State private var isShowingAddView = false

    var body: some View {
   
        NavigationView {
            ScrollView(.vertical) {
                //  LazyVGrid(columns: columns, spacing: 400){
                
                LazyVGrid(columns: items, spacing: 10){
                 
               
                    ZStack{
                        
                      
                        RoundedRectangle(cornerRadius: 6 )
                            
                            
                         
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 4.0, lineCap: .round, dash: [10, 20]))
                            .frame(width: 150, height: 150)
                            .clipShape(Rectangle())
//                            .foregroundColor(Color.white)
//                            .padding(.horizontal)
                        Button(action: { isShowingAddView = true }) { Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20 , height: 20)
                            
                        
                        }
                        //   }
                    }
              
                    
                    ForEach(contacts) { contact in
                        
                        VStack {
                            ZStack{
                                if let image = contact.photo {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150, alignment: .center)
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
                                            Image(systemName: "xmark.square.fill")
                                                .font(.title)
                                            
                                        }
                                        
                                    }
                                
                            }
                            
                            //   Divider()
                            Text(contact.name ?? "None")
                                .padding(-5)
                            
                            
                              
                            
                        }
                        
                    }
                    
                    
                    
                   
                   
                    
                   
              //  }
                
                
            }
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Done" : "Edit") {
                withAnimation { isEditing.toggle() }
                }
                }

                            }
                
        }
                .navigationTitle("Core Data Contacts")
               
        }
        .sheet(isPresented: $isShowingAddView, content: {
            AddContactView(onAdd: { name, image in
                isShowingAddView = false
                addContact(name: name, photo: image)
            }, onCancel: { isShowingAddView = false })
        })
        
    }

    private func addContact(name: String, photo: UIImage?) {
        let newContact = Contact(context: viewContext)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
