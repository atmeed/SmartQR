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
    

    @Published var historyScaner: [String] = ["1", "2"]
    @Published var historyGenerator: [String] = ["1", "2", "3"]

    
}




//Строчки в Истории
struct HistoryRow: View {

    var QR: QR
    
    var body: some View {
        HStack {
            Image(uiImage: QR.image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                
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
                Button("Поделиться изображением") {
                    self.isShowingSharingSheet = true
                }.sheet(isPresented: $isShowingSharingSheet, content: {
                    ShareSheet(activityItems: [QR.image], applicationActivities: nil)
                })
                    
                Spacer()
            
                
            }
        }
    }
    
}

//Поделитсья
struct ShareSheet: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ShareSheet>) {

    }
}

//Просмотр старого QR
struct HistoryView: View {
    let QR: QR
    
    
    
    //Кнопка поделится
    @State private var isShowingSharingSheet = false
    
    //Работа кнопки скопировать
    @State private var copyName = "Копировать текст"
    @State private var copyImage = "arrowshape.turn.up.left"
    
    //Закрытие окна при удалении
    @Environment(\.dismiss) private var dismiss
    
    //Открытие ссылки
    @Environment(\.openURL) var openURL
    
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    
    
    var body: some View {
        Form {
            Section { //Имя QR
                Group {
                    //Название QR
                    HStack {
                        Spacer()
                        Text("\(QR.name)")
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
                        Button("Поделиться изображением") {
                            self.isShowingSharingSheet = true
                        }.sheet(isPresented: $isShowingSharingSheet, content: {
                            ShareSheet(activityItems: [QR.image], applicationActivities: nil)
                        })
                            .padding(.bottom, 10)
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                
            }
            
            
            
            
            
            //Функциональные кнопки
            Section {
                
                Group {
                    
                    //Проверка на ссылку
                    if verifyUrl(urlString: QR.name) {
                        Button(action: {
                            openURL(URL(string: QR.name)!)
                        }) {
                            HStack {
                                Image(systemName: "link")
                                Text("Открыть ссылку")
                            }
                        }
                    }
                    
                
                    //Кнопка скопировать
                    Button(action: {
                        UIPasteboard.general.string = QR.name
                        self.copyName = "Успешно!"
                        self.copyImage = "heart.fill"
                    }) {
                        HStack {
                            
                            Image(systemName: copyImage)
                            if verifyUrl(urlString: QR.name) {
                                Text("Скопировать ссылку")
                            } else {
                                Text(copyName)
                            }
                            
                        }
                    }
                    
                    //Добавить в Apple Pay
                    Button(action: {
                        
                    }) {
                        HStack {
                            Image(systemName: "creditcard")
                            Text("Добавить в Apple pay")
                        }.foregroundColor(.black)
                    }
                    
                    
                    
                }
                

            }
            Section {
                Group {
                    //Кнопка удалить данный QR
                    Button(action: {
                        dismiss()
                        
                    }) {
                        HStack {
                            Image(systemName: "trash")
                            Text("Удалить")
                        }.foregroundColor(.red)
                    }
                }
            }
            
            
            
        }
        
    }
}
