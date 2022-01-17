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
    
    var historyQR: [String] = []
    
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

//Просмотр старого QR
struct HistoryView: View {
    
    let QR: QR
    
    
    
    @State private var isShowingSharingSheet = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section() { //Имя QR
                        
                        
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
                                .padding(.bottom, 10)
                                .padding(.top, 10)
                            Spacer()
                        }
                    }
                    
                    
                    
                }.navigationBarTitle("\(QR.name)")
            }
        }
        
    }
}
