import SwiftUI

struct LoginView: View {
    @Bindable var viewModel: LoginViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()

                Image(systemName: "graduationcap.fill")
                    .font(.system(size: 58))
                    .symbolRenderingMode(.hierarchical)

                Text("Learning App")
                    .font(.largeTitle.bold())

                Text("Sign in to continue")
                    .foregroundStyle(.secondary)

                VStack(spacing: 12) {
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.callout)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                Button {
                    Task { await viewModel.login() }
                } label: {
                    if viewModel.isLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text("Login").fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.isLoading)

                Text("Demo: test@example.com / password123")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: 480)
            .frame(maxWidth: .infinity)
        }
    }
}
