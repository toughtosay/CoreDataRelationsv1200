//
//  ContentView.swift
//  CoreDataRelationsv1200
//
//  Created by Andree Carlsson on 2022-10-21.
//

//MARK: Detta bör kunna klippas om och ge allt jag behöver. Persistence är ren och fin, även om vi inte använt menyalternativet så finns alla relationsparametrar (se item-CoreDataPropertiesfilen som jag pinnat). NSSet alternativet verkar fungera bra. Se så att du ställer in rätt med to many i den riktiga filen, album ska ha to many. Upplägget med flera Views som används här behövs inte. Kan vara MVC dock, fråga Bill. OM du återbesäker detta efter en tid, det är inte så rörigt eller svårt som det verkar. Persistens är alla inställningar för containers och vad du behöver. Sen använder du fetchrequests för att få fram datan och för funcs för att spara/delete. Fråga Bill hur det fungerar med vilka funktioner och variabler som kan hämtas i vilken vy. Ibland kan man ange den direkt i en vy och ibland måste man kalla på den ellr göra ny func. 
    

import SwiftUI

struct ContentView: View {
    
    @State private var isAddCategoryViewPreseted = false
    //MARK: Fetchrequest med sortdescriptors för att kunna sortera i alfabetsik ordning.
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.value, ascending: true)],
        animation: .default)
    //MARK: Variabel för att hämta ner alla resultat i Category som blivit fetched, gör i loopen nedan.
    private var categories: FetchedResults<Category>
    
    var body: some View {
        
        List {
            ForEach(categories) { category in
                NavigationLink {
                    //MARK: Vad händer här? I predicate. Det är för att få in Items. Men hur fungerar det?
                    let itemsFetchRequest = FetchRequest<Item>(sortDescriptors: [NSSortDescriptor(keyPath: \Item.value, ascending: true)],
                        predicate: NSPredicate(format: "%K CONTAINS[cd] %@", #keyPath(Item.categories), category), animation: .default)
                    CategoryView(category: category, items: itemsFetchRequest)
                } label: {
                    Text(category.value ?? "")
                }
            }
            .onDelete(perform: delete(offsets:))
        }
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isAddCategoryViewPreseted.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                    
                }
                .sheet(isPresented: $isAddCategoryViewPreseted) {
                    AddCategoryView()
                }
            }
        }
    }
    private func delete(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { offset in
                let category = categories[offset]
                do {
                    try PersistenceController.shared.delete(category)
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    
