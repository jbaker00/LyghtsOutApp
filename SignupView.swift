import SwiftUI
import MessageUI

struct SignupView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var sessionIndex = 0
    @State private var notes = ""
    @State private var showMailComposer = false
    @State private var mailResult: Result<MFMailComposeResult, Error>? = nil
    @State private var showMailError = false

    let sessions = ["Private Training", "Group Training", "Camp"]
    let contactEmail = "lyghtsoutlacrosse90@gmail.com"
    let instagramURL = URL(string: "https://www.instagram.com/lyghtsoutlacrosse.90/")!
    let profileImageURL = URL(string: "https://scontent-sea1-1.cdninstagram.com/v/t51.82787-19/599723921_17919069570212921_5449150773894989501_n.jpg?stp=dst-jpg_s100x100_tt6&_nc_cat=104&ccb=7-5&_nc_sid=bf7eb4&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLnd3dy4xMDgwLkMzIn0%3D&_nc_ohc=K0krlj7eia0Q7kNvwFM50yU&_nc_oc=Adm2E1xCzuynpBlQo8UTFs-tYbVxsgCurLU08IXJXknDScsHtD-kVfGZQr0dRJt0FZQ&_nc_zt=24&_nc_ht=scontent-sea1-1.cdninstagram.com&_nc_gid=12ZW5O1Hpod57Gjk2RNi-w&oh=00_AfvXTu_5x3uJXxcHuKDSK8WpyOj0TTBxjmS-bwhBAr1Tjg&oe=699C04CD")

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // MARK: Logo
                if let url = profileImageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView().frame(height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 160, maxHeight: 160)
                                .cornerRadius(12)
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // MARK: Instagram Link
                Link(destination: instagramURL) {
                    Label("@lyghtsoutlacrosse.90", systemImage: "camera")
                        .font(.subheadline.bold())
                }

                // MARK: Training Info
                cardSection {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("What You'll Train")
                            .font(.headline)
                        label("Stick work — shooting, ground balls, passing, catching")
                        label("Positional based training")
                        label("Fitness, speed & agility training")
                        Divider()
                        Text("All ages & skill levels · Sessions customized to your needs and goals.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Divider()
                        Text("Credentials")
                            .font(.headline)
                        Group {
                            Text("University of Notre Dame '27 · Seton Hall Prep '23 Captain · Leading Edge Elite '23")
                            Text("2025 — Co Schmeisser Award, ACC Co DPOY, IL & USILA 1st Team All-American")
                            Text("2024 — NCAA National Champion, USILA 2nd Team All-America, NCAA All-Tournament Team")
                            Text("2023 — NJ Defenseman of the Year, Nike & New Balance All-American, 2× USA Lacrosse All-American")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }

                // MARK: Sign-Up Form
                VStack(alignment: .leading, spacing: 4) {
                    sectionHeader("Contact")
                    cardSection {
                        VStack(spacing: 0) {
                            inputRow { TextField("Full name", text: $name) }
                            Divider().padding(.leading, 16)
                            inputRow { TextField("Email", text: $email).keyboardType(.emailAddress).autocapitalization(.none) }
                            Divider().padding(.leading, 16)
                            inputRow { TextField("Phone", text: $phone).keyboardType(.phonePad) }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    sectionHeader("Session Type")
                    cardSection {
                        VStack(spacing: 0) {
                            ForEach(0..<sessions.count, id: \.self) { i in
                                Button {
                                    sessionIndex = i
                                } label: {
                                    HStack {
                                        Text(sessions[i])
                                            .foregroundColor(.primary)
                                        Spacer()
                                        if sessionIndex == i {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(.accentColor)
                                        }
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                }
                                if i < sessions.count - 1 {
                                    Divider().padding(.leading, 16)
                                }
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: 4) {
                    sectionHeader("Notes")
                    cardSection {
                        TextEditor(text: $notes)
                            .frame(height: 100)
                            .padding(4)
                    }
                }

                Button(action: submit) {
                    Text("Sign Up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Text("Pricing available for multi-session packages and larger groups. Contact for details.")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.bottom, 24)
            }
            .padding(.top, 8)
        }
        .sheet(isPresented: $showMailComposer) {
            MailView(subject: "LyghtsOut Signup: \(name)", recipients: [contactEmail], body: composeBody(), isShowing: $showMailComposer, result: $mailResult)
        }
        .alert("Unable to send mail", isPresented: $showMailError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This device cannot send mail. The Mail app will be opened instead.")
        }
    }

    // MARK: Helpers

    @ViewBuilder
    func cardSection<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .padding(.horizontal)
    }

    @ViewBuilder
    func inputRow<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        content()
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
    }

    func sectionHeader(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal, 32)
    }

    func label(_ text: String) -> some View {
        Label(text, systemImage: "checkmark.circle.fill")
            .font(.subheadline)
            .foregroundColor(.secondary)
    }

    func composeBody() -> String {
        "Name: \(name)\nEmail: \(email)\nPhone: \(phone)\nSession: \(sessions[sessionIndex])\nNotes: \(notes)"
    }

    func submit() {
        let subject = "LyghtsOut Signup: \(name)"
        let body = composeBody()
        if MFMailComposeViewController.canSendMail() {
            showMailComposer = true
        } else {
            let subjectEscaped = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let bodyEscaped = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let address = "mailto:\(contactEmail)?subject=\(subjectEscaped)&body=\(bodyEscaped)"
            if let url = URL(string: address) {
                UIApplication.shared.open(url)
            } else {
                showMailError = true
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}


