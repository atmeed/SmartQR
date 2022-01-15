//
//  GeneratorView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 15.01.2022.
//

import SwiftUI


//Строчки в Истории
struct HistoryRow: View {
    
    var QR: QR
    
    var body: some View {
        HStack {
            Image(uiImage: QR.image)
            Text(QR.name)
            
        }
    }
}

//Просмотр старого QR
struct HistoryView: View {
    var QR: QR
    
    var body: some View {
        VStack {
            Image(uiImage: QR.image)
        }
    }
}


struct GeneratorView: View {
    
    @State private var historyQR = ["Test", "Text", "Free", "Pee"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                //Последний QR
                
                
                //История создания
                Form {
                    if historyQR.count > 0 { //Удаление истории приводит к удалению всего View
                        Section(header: Text("История")) {
                            List {
                                ForEach(historyQR, id: \.self) { qr in
                                    NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                                        HistoryRow(QR: StringToQR(name: qr))
                                    }
                                }
                            }
                            
                            //Удаление всей истории QR
                            HStack{
                                Button("Удалить всю истроию") {
                                    self.historyQR = []
                                }
                                .foregroundColor(.red)
                                
                                    
                            }
                        }
                    }
                    
                }
            }.navigationTitle("Создание QR")
            
        }
        
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
    }
}
