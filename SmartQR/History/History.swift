//
//  History.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 17.01.2022.
//

import Foundation
import SwiftUI

//Класс с данными
class History: ObservableObject { //Используется как в Генерации, так и в сканировании
    
    
    @Published var historyQR: [String] = []

    init(history: [String]) {
        self.historyQR = history
    }

    
}




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





//Последний QR в GeneratorView
struct LastQR: View {

    let QR: QR
    
    @State private var isShowingSharingSheet = false
    
    
    var body: some View {
        
        Section {
            
            //Имя QR
            HStack {
                Spacer()
                Text("\(QR.name)").font(.title2)
    
                Spacer()
            }
                
            
            //Изображение самого QR
            Image(uiImage: QR.image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
            
            
            //Кнопка поделиться
            HStack {
                Spacer()
                Button("Поделиться") {
                    self.isShowingSharingSheet = true
                }.sheet(isPresented: $isShowingSharingSheet, content: {
                    ShareSheet(activityItems: [QR.image], applicationActivities: nil)
                })
                    
                Spacer()
            
                
            }
        }
    }
    
}
