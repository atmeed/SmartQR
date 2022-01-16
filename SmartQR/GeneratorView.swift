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
    
    @State private var isShowingSharingSheet = false
    
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Text("\(QR.name)").font(.headline)
                    Spacer()
                }
                Image(uiImage: QR.image)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
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
}



//BODY
struct GeneratorView: View {
    
    @State private var historyQR = ["Test", "Text", "Free", "Pe"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                //Последний QR
                
                
                
                
                
                
                
                
                //Создание нового QR
                
                
                
                
                
                
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
