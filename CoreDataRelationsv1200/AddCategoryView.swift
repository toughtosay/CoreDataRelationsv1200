//
//  AddCategoryView.swift
//  CoreDataRelationsv1200
//
//  Created by Andree Carlsson on 2022-10-21.
//

import SwiftUI

struct AddCategoryView: View {
    
    @State private var textfieldtext = ""
    
    //MARK: Efter att vi sparar vill vi att vyn ska dismiss
    @Environment(\.dismiss) private var dismiss
    
    //MARK: "Grabb the Viewcontext. Osäker på varför.
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            TextField("Category", text: $textfieldtext)
                .textFieldStyle(.roundedBorder)
            
            Button(action: {
                save()
            }, label: {
                Text("Save")
                
            })
           .buttonStyle(.borderedProminent)
            Spacer()
        }
        .padding()
    }
    
    func save() {
        //MARK: Sparar i Entity Category tror jag. Får in viewContext från environment
        let category = Category(context: viewContext)
        //MARK: Category får nu sitt värde och ska inehålla Textfieldtext
        category.value = textfieldtext
        do {
            try PersistenceController.shared.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
       
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}
