//
//  GeneratorView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 15.01.2022.
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



struct LastQR: View {

    let QR: QR
    
    @State private var isShowingSharingSheet = false
    
    
    var body: some View {
        
        VStack {
            
            //Имя QR
            HStack {
                Spacer()
                Text("\(QR.name)")
    
                Spacer()
            }.padding(.top, 10)
                
            
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
                Spacer()
            
                
            }
        }
    }
    
}



//BODY
struct GeneratorView: View {
    
    @ObservedObject var history = History()
    
    
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                Form {
                    
                    
                    if history.historyQR.count > 0 { //Удаление истории приводит к удалению всего View
                        //Последний QR
                        VStack {
                            LastQR(QR: StringToQR(name: history.historyQR[0]))
                        }
                        
                        
                        //История создания QR
                        Section(header: Text("История")) {
                            List {
                                ForEach(history.historyQR, id: \.self) { qr in
                                    NavigationLink(destination: HistoryView(QR: StringToQR(name: qr))) {
                                        HistoryRow(QR: StringToQR(name: qr))
                                    }
                                }
                            }
                            
                            //Удаление всей истории QR
                            HStack{
                                Button("Удалить всю истроию") {
                                    history.historyQR = []
                                }
                                .foregroundColor(.red)
                                
                                    
                            }
                        }
                    }
                    
                }
            }.navigationTitle("Последний QR")
            
        }
        
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
    }
}
