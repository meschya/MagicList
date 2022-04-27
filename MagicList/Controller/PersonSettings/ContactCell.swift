import SwiftUI

struct ContactCell: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Name")

                        .font(Font(uiFont: .altone(20, .medium)))
                    Text("SurName")
                        .font(Font(uiFont: .altone(20, .light)))
                        .offset(x: 30)
                    Spacer()
                    Text("Status")
                        .font(Font(uiFont: .altone(20, .medium)))
                    Text("Phone")
                        .font(Font(uiFont: .altone(20, .light)))
                        .opacity(0.8)
                        .offset(x: 30)
                }
                Spacer()
                VStack {
                    Image(systemName: "phone")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding()
                }
            }
        }
        .padding()
        .background(Color.theme.cellColor)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ContactCell_Previews: PreviewProvider {
    static var previews: some View {
        ContactCell()
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 350, height: 150))
    }
}
