import SwiftUI

struct PersonSettingsSwiftUIView: View {

    @ObservedObject var person = User()

    var body: some View {

        NavigationView {
            ZStack {
                Color.theme.background
                VStack {
                    ForEach(person.user) { user in
                        Spacer()

                        Image(user.image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .rotationEffect(.degrees(person.rotation)).animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))
                        Spacer()
                        HStack {
                            Text(user.surName)
                                .font(Font(uiFont: .altone(25, .regular)))

                            Text(user.name)
                                .font(Font(uiFont: .altone(30, .medium)))
                        }
                        Spacer()
                        HStack {
                            Text("+")
                                .font(Font(uiFont: .altone(25, .medium)))

                            Text("375")
                                .font(Font(uiFont: .altone(23, .regular)))

                            Text("(\(user.phonePrefix))")
                                .font(Font(uiFont: .altone(25, .medium)))
                                .foregroundColor(.theme.accent)
                            Text(user.phoneNumber)
                                .font(Font(uiFont: .altone(23, .regular)))
                        }
                        Spacer()
                    }
                }
                .padding()
                .rotationEffect(.degrees(person.rotation)).animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))
                .frame(width: 350, height: 450)
                .background(Color.theme.cellColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .navigationTitle(Text("Profile"))
                .navigationBarItems(trailing: Button {
                    person.showSheet = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(.all, 10)
                        .background(Color.theme.accent)
                        .clipShape(Circle())
                        .foregroundColor(Color.theme.background)
                }
                .actionSheet(isPresented: $person.showSheet) {
                    ActionSheet(title: Text("Create Your Profile"),
                                message: Text("There is no turning back"),
                                buttons: [
                                    .default(Text("Yes")) {
                                        CoreDataManager.instance.deleteAllPerson(self.person.user)
                                        person.showInformation = true

                                    },
                                    .destructive(Text("No"))

                                ])
                })
                .sheet(isPresented: $person.showInformation){
                   
                    PersonInformation(person: self.person)
                   
                }
                
            }
            .gesture(TapGesture(count: 1).onEnded { _ in
                person.rotation += 360

            })

            .shadow(color: Color.theme.title, radius: 10, x: 0, y: 10)
            .ignoresSafeArea()
        }
        .onAppear{
            guard let persons = CoreDataManager.instance.getPerson() else { return }
            self.person.user = persons
            
            }
        }
    

    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.theme.accent!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.theme.accent!]
        navBarAppearance.backgroundColor = UIColor.theme.background
    }
}

#if DEBUG
struct PersonSettingsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PersonSettingsSwiftUIView()
            .preferredColorScheme(.dark)
    }
}
#endif
