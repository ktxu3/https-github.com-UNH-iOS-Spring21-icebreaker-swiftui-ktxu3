//
//  ContentView.swift
//  Icebreaker
//
//  Created by kuntong xu on 3/24/21.
//

import SwiftUI
import FirebaseFirestore

struct ContentView: View {
    let db = Firestore.firestore()
    @State var questions = [Question]()
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var preferredName: String = ""
    @State var anwser: String = ""
    @State var question: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Icebreaker")
                .font(.system(size: 36))
                .bold()
            Text("Build with Swift")
                .font(.system(size: 30))
                .bold()
            TextField("First Name", text: $firstName)
                .font(.largeTitle)
                .disableAutocorrection(true)
            TextField("Last Name", text: $lastName)
                .font(.largeTitle)
                .disableAutocorrection(true)
            TextField("Preferred Name", text: $preferredName)
                .font(.largeTitle)
                .disableAutocorrection(true)
           
            Button(action: {
                getRandomQuestion()
            }){
                Text("Get a new random question.")
                    .font(.system(size: 20))
            }
            Text(question)
                .font(.system(size: 30))
            TextField("Answer", text: $anwser)
                .font(.largeTitle)
                .disableAutocorrection(true)
            Divider()
            Button(action: {submit()}) {
                Text("Submit")
                    .font(.system(size: 30))
            }
        }
        .onAppear(perform: getQuestionsData)
        
    }
    func submit(){
            let data = ["first_name": firstName,
                                "last_name": lastName,
                                "preferred_name": preferredName,
                                "question": question,
                                "answer": anwser,
                                "class": "ios_spring21"]
                    as [String: Any]
                    
                    var ref: DocumentReference? = nil
                    ref = db.collection("students").addDocument(data: data) {err in
                        if let err = err {
                            print("error getting documents:\(err)")
                        }else {
                            print("Document added with ID: \(ref!.documentID)")
                        }
                    }
        }
    
    func getRandomQuestion(){
        question = questions.randomElement()!.text
    }
    func getQuestionsData(){
        db.collection("Questions")
        .getDocuments() {
            (QuerySnapshot, err) in
            if let err = err {
                print("error getting documents:\(err)")
            }else {
                for document in QuerySnapshot!.documents {
                    if let question = Question(id: document.documentID, data: document.data()) {
                        self.questions.append(question)
                    }
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
