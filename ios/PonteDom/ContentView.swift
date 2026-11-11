import SwiftUI
import WebKit

private enum AppConfig {
    static let homeURL = URL(string: "https://thebestjob.github.io/app-pontedom/")!
}

struct ContentView: View {
    @StateObject private var browser = BrowserModel()

    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.98, blue: 1).ignoresSafeArea()
            PonteDomWebView(browser: browser)
                .ignoresSafeArea(edges: .bottom)
            if browser.isLoading {
                ProgressView().tint(.blue)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding(.top, 12)
                    .allowsHitTesting(false)
            }
            if browser.loadFailed {
                VStack(spacing: 12) {
                    Text("Unable to connect to PonteDom").font(.headline)
                    Text("Check your internet connection and try again.")
                        .font(.subheadline).foregroundStyle(.secondary)
                    Button("Try again") { browser.reload() }
                        .buttonStyle(.borderedProminent)
                }
                .padding(24)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
                .padding()
            }
        }
        .background(Color.white)
    }
}

final class BrowserModel: ObservableObject {
    @Published var isLoading = false
    @Published var loadFailed = false
    weak var webView: WKWebView?

    func reload() {
        loadFailed = false
        webView?.load(URLRequest(url: AppConfig.homeURL))
    }
}

struct PonteDomWebView: UIViewRepresentable {
    @ObservedObject var browser: BrowserModel

    func makeCoordinator() -> Coordinator { Coordinator(browser: browser) }

    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.websiteDataStore = .default()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.navigationDelegate = context.coordinator
        view.uiDelegate = context.coordinator
        view.allowsBackForwardNavigationGestures = true
        view.scrollView.contentInsetAdjustmentBehavior = .automatic
        view.isOpaque = false
        view.backgroundColor = UIColor(red: 0.97, green: 0.98, blue: 1, alpha: 1)
        browser.webView = view
        view.load(URLRequest(url: AppConfig.homeURL))
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        private let browser: BrowserModel
        init(browser: BrowserModel) { self.browser = browser }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            browser.isLoading = true
            browser.loadFailed = false
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            browser.isLoading = false
            browser.loadFailed = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            browser.isLoading = false
            if (error as NSError).code != NSURLErrorCancelled { browser.loadFailed = true }
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            browser.isLoading = false
            if (error as NSError).code != NSURLErrorCancelled { browser.loadFailed = true }
        }

        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel); return
            }
            let scheme = (url.scheme ?? "").lowercased()
            if scheme == "mailto" || scheme == "tel" {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            }
            if scheme != "https" && scheme != "about" {
                decisionHandler(.cancel)
                return
            }
            // Keep the hosted app in the shell; external sites open in Safari.
            if let host = url.host?.lowercased(), host != "thebestjob.github.io" {
                if navigationAction.navigationType == .linkActivated {
                    UIApplication.shared.open(url)
                    decisionHandler(.cancel)
                    return
                }
            }
            decisionHandler(.allow)
        }

        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil, let url = navigationAction.request.url,
               url.scheme == "https" {
                UIApplication.shared.open(url)
            }
            return nil
        }
    }
}
