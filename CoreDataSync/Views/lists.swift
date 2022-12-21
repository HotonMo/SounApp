//
//  lists.swift
//  Soun
//
//  Created by Hajar on 17/05/1444 AH.
//

import Foundation
import SwiftUI


//identifier for the folder
struct Folder: Identifiable, Equatable {
    static func == (lhs: Folder, rhs: Folder) -> Bool {
        return true
    }
    
    let id = UUID()
    var name : String
    var files : [File] = [] //initially empty
}


//identifier for the file
struct File: Identifiable {
    let id = UUID()
    var name : String
    var type : String
    var category : String
    var hospitalNmae : String
    var folder : String //name of the folder asit is
}


//identifier for the user
struct User: Identifiable {
    let id = UUID()
    var name : String
    var email : String
    var pass : String
    var folders : [Folder]
}


//list of users
var userList = [
    User(name: "Caspar", email: "caspar12@gmail.com", pass: "123", folders:[
        Folder(name: "Caspar", files:[
            File(name: "first f", type: "pdf", category: "medicine", hospitalNmae: "habib hospital", folder: "Caspar's first"),
            File(name: "second f", type: "png", category: "reports", hospitalNmae: "kingdom hospital", folder: "Caspar's first")
        ]),
        Folder(name: "Luis", files:[
            File(name: "first f", type: "pdf", category: "reports", hospitalNmae: "KFSHRC", folder: "Caspar's second"),
            File(name: "second f", type: "pdf", category: "reports", hospitalNmae: "kingdom hospital", folder: "Caspar's second")
        ])
    ]),
    
    
    
    User(name: "Luis", email: "luis22@gmail.com", pass: "345", folders:[
        Folder(name: "Luis's first", files:[
            File(name: "first f", type: "pdf", category: "x-ray", hospitalNmae: "habib hospital", folder: "Luis's first"),
            File(name: "second f", type: "png", category: "reports", hospitalNmae: "kingdom hospital", folder: "Luis's first")
        ]),
        Folder(name: "Luis's second", files:[
            File(name: "first f", type: "pdf", category: "lab results", hospitalNmae: "KFSHRC", folder: "Luis's second"),
            File(name: "second f", type: "pdf", category: "reports", hospitalNmae: "kingdom hospital", folder: "Luis's second")
        ])
    ]),
    
    
    
    User(name: "Justin", email: "justjus@gmail.com", pass: "567", folders:[
        Folder(name: "Justin's first", files:[
            File(name: "first f", type: "pdf", category: "x-ray", hospitalNmae: "habib hospital", folder: "Justin's first"),
            File(name: "second f", type: "png", category: "reports", hospitalNmae: "kingdom hospital", folder: "Justin's first")
        ]),
        Folder(name: "Justin's second", files:[
            File(name: "first f", type: "pdf", category: "lab results", hospitalNmae: "KFSHRC", folder: "Justin's second"),
            File(name: "second f", type: "pdf", category: "reports", hospitalNmae: "kingdom hospital", folder: "Justin's second")
        ]),
        Folder(name: "Justin's third", files:[
            File(name: "first f", type: "pdf", category: "reports", hospitalNmae: "habib hospital", folder: "Justin's third")
        ]),
    ]),
]
