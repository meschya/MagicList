import SwiftUI

struct PersonInformation: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var person: User

    var body: some View {
        ZStack {
            Color.theme.background

            VStack(spacing: 30) {
                HStack {
                    Spacer()
                    Button {
                        let users = UserSettings(name: person.name,
                                                 surName: person.surName,
                                                 phoneNumber: person.phoneNumber,
                                                 phonePrefix: person.phonePrefix,
                                                 image: person.image)
                        CoreDataManager.instance.savePerson(users)

                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .foregroundColor(Color.theme.accent)
                        .opacity(person.isValid ? 1 : 0).animation(.spring())
                    }
                    .disabled(!person.isValid)
                }
                .padding(.horizontal, 30)
                .padding(.bottom)
                ZStack {
                    Color.theme.cellColor

                    VStack {
                        ZStack {
                            Text("Name")
                                .foregroundColor(Color.theme.title)
                                .opacity(1)
                                .offset(y: person.name.isEmpty ? -4 : -25)
                                .animation(.easeInOut(duration: 2))
                                .font(Font(uiFont: .altone(23, .thin)))
                            Spacer()

                            VStack {
                                TextField("", text: $person.name)
                                    .disableAutocorrection(true)
                                Divider()
                                    .background(person.name.isEmpty ? Color.theme.accent : Color.green)
                                    .animation(.linear(duration: 1))
                                    .offset(y: -7)
                            }
                            .frame(width: 280)
                            .offset(y: 3)
                        }
                        .padding()
                        ZStack {
                            Text("Surname")
                                .foregroundColor(Color.theme.title)
                                .opacity(0.9)
                                .offset(y: person.surName.isEmpty ? -4 : -25)
                                .animation(.easeInOut(duration: 1))
                                .font(Font(uiFont: .altone(23, .thin)))
                            Spacer()

                            VStack {
                                TextField("", text: $person.surName)
                                    .disableAutocorrection(true)

                                Divider()
                                    .background(person.surName.isEmpty ? Color.theme.accent : Color.green)
                                    .animation(.linear(duration: 2))
                                    .offset(y: -7)
                            }
                            .frame(width: 280)
                            .offset(y: 3)
                        }
                        .padding()
                    }
                }
                .frame(width: 350, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                ZStack {
                    Color.theme.cellColor

                    VStack {
                        ZStack {
                            HStack {
                                Text("+375")
                                    .padding(.leading, 30)
                                    .font(Font(uiFont: .altone(25, .extraBold)))

                                Picker(selection: $person.phonePrefix) {
                                    ForEach(person.prefix, id: \.self) {
                                        Text("(\($0))")
                                            .foregroundColor(Color.theme.accent)
                                    }
                                } label: {
                                    Text("")
                                }.pickerStyle(.menu)
                                    .frame(width: 10, height: 40)
                                    .padding(.horizontal)
                                TextField("Number", text: $person.phoneNumber)
                                    .keyboardType(.numberPad)
                                    .frame(width: 100)
                                    .font(Font(uiFont: .altone(20, .bold)))

                                Spacer()
                            }
                        }
                    }
                }
                .frame(width: 350, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                ZStack {
                    Color.theme.cellColor

                    VStack {
                        ZStack {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(person.arrayImage, id: \.self) { img in
                                        Button {
                                            person.image = String(img)
                                        } label: {
                                            Image(String(img))
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .clipShape(Circle())
                                                .padding(.horizontal, 5)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                }
                .frame(width: 350, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .padding(.vertical, 50)
        }
        .ignoresSafeArea()
        .onAppear {
            person.isFormValid
                .receive(on: RunLoop.main)
                .assign(to: \.person.isValid, on: self)
                .store(in: &person.cancellable)
        }
    }
}

#if DEBUG
struct PersonInformation_Previews: PreviewProvider {
    static var previews: some View {
        PersonInformation(person: User())
            .preferredColorScheme(.dark)
    }
}
#endif
