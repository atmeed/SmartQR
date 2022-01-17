//
//  HistoryChoisingQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 17.01.2022.
//

import SwiftUI


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

struct HistoryView: View {
    let QR: QR

    @State private var isShowingSharingSheet = false
    
    
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
                
            }
            
            //Функциональные кнопки
            Section {
                
                Group {
                    //Кнопка скопировать
                    Button(action: {
                        UIPasteboard.general.string = QR.name
                    }) {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Скопировать")
                        }
                    }
                    
                    //Кнопка удалить данный QR
                    Button(action: {
                        
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

