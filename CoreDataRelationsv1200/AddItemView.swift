//
//  AddItemView.swift
//  CoreDataRelationsv1200
//
//  Created by Andree Carlsson on 2022-10-23.
//

import SwiftUI

struct AddItemView: View {
    
    //MARK: Få access till vår ViewContext.
    @Environment(\.managedObjectContext) private var viewContext
    //
    @Environment(\.dismiss) private var dismiss
    
    @State private var textfieldtext = ""
    //MARK: Initierar Category där vi ska spara Items!
    var category: Category
    
    var body: some View {
        VStack {
            TextField("Item", text: $textfieldtext)
                .textFieldStyle(.roundedBorder)
            
            Button {
                save()
                
            } label: {
                Text("Save")
            }
                Spacer()
        }
        .padding()
    }
    
    func save() {
        //MARK: Anldeningen till vår enviroment högst upp var för att kunnna ge item denna viewContext.
        let item = Item(context: viewContext)
        item.value = textfieldtext
        item.addToCategories(category)
        do {
            try PersistenceController.shared.save()
            dismiss()
        } catch {
            print(error.localizedDescription)

        }
    }
}

//MARK: Delete preview för den behövs inte"
