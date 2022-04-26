import SwiftUI

struct PersonSettingsSwiftUIView: View {
    @State private var showInformation = false
    @ObservedObject var person = User()
    @State private var rotation: Double = 360
    var body: some View {

        NavigationView {
            ZStack {
                Color.theme.background
                VStack {

                    Spacer()

                    Image("2")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .rotationEffect(.degrees(rotation)).animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))

                    Spacer()
                    HStack {
                        Text(person.surName)
                            .font(Font(uiFont: .altone(25, .regular)))

                        Text(person.name)
                            .font(Font(uiFont: .altone(30, .medium)))
                    }
                    Spacer()
                    HStack {
                        Text("+")
                            .font(Font(uiFont: .altone(25, .medium)))

                        Text("375")
                            .font(Font(uiFont: .altone(23, .regular)))

                        Text("(\(person.phonePrefix))")
                            .font(Font(uiFont: .altone(25, .medium)))
                            .foregroundColor(.theme.accent)
                        Text(person.phoneNumber)
                            .font(Font(uiFont: .altone(23, .regular)))
                    }
                    Spacer()
                }
                .padding()
                .rotationEffect(.degrees(rotation)).animation(.spring(response: 1, dampingFraction: 2, blendDuration: 1))
                .frame(width: 350, height: 450)
                .background(Color.theme.cellColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .navigationTitle(Text("Profile"))
                .navigationBarItems(trailing: Button {
                    showInformation = true
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .padding(.all, 10)
                        .background(Color.theme.accent)
                        .clipShape(Circle())
                        .foregroundColor(Color.theme.background)

                })
                .sheet(isPresented: $showInformation, content: {
                    PersonInformation(person: User())
                })
            }
            .gesture(TapGesture(count: 1).onEnded({ _ in
                rotation += 360
            }))

            .shadow(color: Color.white, radius: 10, x: 0, y: 10)
            .ignoresSafeArea()
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
