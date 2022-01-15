//
//  GeneratorView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 15.01.2022.
//

import SwiftUI


//Строчки в Истории
struct HistoryRow: View {
    
    var QR: StringToQR
    
    var body: some View {
        HStack {
            Image(uiImage: QR.image)
            Text(QR.name)
            
        }
    }
}

//Просмотр старого QR
struct HistoryView: View {
    var QR: StringToQR
    
    var body: some View {
        VStack {
            Image(uiImage: QR.image)
        }
    }
}


struct GeneratorView: View {
    
    var historyQR = ["Test", "Text", "Free"]
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                //История создания
                Form {
                    Section(header: Text("История")) {
                        List {
                            ForEach(historyQR, id: \.self) { qr in
                                NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                                    HistoryRow(QR: StringToQR(name: qr))
                                }
                                    
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
