import SwiftUI
import WebKit
import AVFoundation

struct ContentView: View {
    var body: some View {
        WebView(url: URL(string: "https://h0f7p7wxgb.execute-api.ap-northeast-2.amazonaws.com/ryan/ryan-iframe-test")!)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        // WKWebViewConfiguration 설정
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.allowsInlineMediaPlayback = true // 인라인 재생 허용
        configuration.mediaTypesRequiringUserActionForPlayback = [] // 자동 재생 설정
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.suppressesIncrementalRendering = false

    
        // WKWebView 인스턴스 생성
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.isInspectable = true
   
        // 기존 userAgent 가져오기
        webView.evaluateJavaScript("navigator.userAgent") { (result, error) in
           if let userAgent = result as? String {
               // userAgent 끝에 " Pagecall" 추가
               let customUserAgent = userAgent + " Safari Pagecall"
               webView.customUserAgent = customUserAgent
           }
        }
        
        // 마이크 권한 요청
        AVAudioApplication.requestRecordPermission { granted in
            if granted {
                    // 마이크 접근이 허용되었을 때의 로직
                    print("We have access to the microphone.")
            } else {
                    // 마이크 접근이 거부되었을 때의 로직
                    print("Permission to access the microphone was denied.")
            }
        }
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
    func makeCoordinator() -> Coordinator {
            Coordinator()
        }

        class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
            @available(iOS 15.0, *)
            public func webView(
                _ webView: WKWebView,
                requestMediaCapturePermissionFor origin: WKSecurityOrigin,
                initiatedByFrame frame: WKFrameInfo,
                type: WKMediaCaptureType,
                decisionHandler: @escaping (WKPermissionDecision) -> Void
            ) {
                    decisionHandler(.grant)
            }
        }
}

// 프리뷰
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

