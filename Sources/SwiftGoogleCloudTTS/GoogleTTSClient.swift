//
//  GoogleTTSClient.swift
//  AuthPackageDescription
//
//  Created by Baris Atamer on 1/16/20.
//

import Foundation
import NIO
import OAuth2
import NIOHPACK
import GRPC

public class GoogleTTSClient {
    
    deinit {
        try? eventLoopGroup.syncShutdownGracefully()
    }
    
    enum AuthError: Error {
        case noTokenProvider
        case tokenProviderFailed
    }
    
    struct Constants {
        static let host: String = "texttospeech.googleapis.com"
        static let port: Int = 443
        static let scopes: [String] = ["https://www.googleapis.com/auth/cloud-platform"]
    }
    
    public let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    
    // MARK: Public Initializer
    
    public init() {}
    
    // MARK: Public Methods
    
    /// Returns a list of Voice supported for synthesis.
    public func listVoices(
        request: Google_Cloud_Texttospeech_V1_ListVoicesRequest
    ) throws -> EventLoopFuture<Google_Cloud_Texttospeech_V1_ListVoicesResponse> {
        let client = makeServiceClient(
            host: Constants.host,
            port: Constants.port,
            eventLoopGroup: eventLoopGroup
        )
        return try prepareCallOptions(eventLoopGroup: eventLoopGroup)
            .flatMap { callOptions -> EventLoopFuture<Google_Cloud_Texttospeech_V1_ListVoicesResponse> in
                return client.listVoices(request, callOptions: callOptions).response
        }
    }
    
    /// Synthesizes speech synchronously: receive results after all text input
    /// has been processed.
    public func synthesizeSpeech(
        request: Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest
    ) throws -> EventLoopFuture<Google_Cloud_Texttospeech_V1_SynthesizeSpeechResponse> {
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let client = makeServiceClient(
            host: Constants.host,
            port: Constants.port,
            eventLoopGroup: eventLoopGroup
        )
        return try prepareCallOptions(eventLoopGroup: eventLoopGroup)
            .flatMap { callOptions -> EventLoopFuture<Google_Cloud_Texttospeech_V1_SynthesizeSpeechResponse> in
                return client.synthesizeSpeech(request, callOptions: callOptions).response
        }
    }

    // MARK: Private Methods
    
    private func prepareCallOptions(eventLoopGroup: EventLoopGroup) throws -> EventLoopFuture<CallOptions> {
        return getAuthToken(
            scopes: Constants.scopes,
            eventLoop: eventLoopGroup.next()
        ).map { authToken -> (CallOptions) in
            // Use CallOptions to send the auth token (necessary) and set a custom timeout (optional).
            let headers: HPACKHeaders = ["authorization": "Bearer \(authToken)"]
            let callOptions = CallOptions(customMetadata: headers, timeout: .seconds(rounding: 30))
            debugPrint("CALL OPTIONS\n\(callOptions)\n")
            return callOptions
        }
    }
    
    /// Get an auth token and return a future to provide its value.
    private func getAuthToken(
        scopes: [String],
        eventLoop: EventLoop
    ) -> EventLoopFuture<String> {
        let promise = eventLoop.makePromise(of: String.self)
        guard let provider = DefaultTokenProvider(scopes: scopes) else {
            promise.fail(AuthError.noTokenProvider)
            return promise.futureResult
        }
        do {
            try provider.withToken { (token, error) in
                if let token = token,
                    let accessToken = token.AccessToken {
                    promise.succeed(accessToken)
                } else if let error = error {
                    promise.fail(error)
                } else {
                    promise.fail(AuthError.tokenProviderFailed)
                }
            }
        } catch {
            promise.fail(error)
        }
        return promise.futureResult
    }

    /// Create a client and return a future to provide its value.
    private func makeServiceClient(
        host: String,
        port: Int,
        eventLoopGroup: MultiThreadedEventLoopGroup
    ) -> Google_Cloud_Texttospeech_V1_TextToSpeechServiceClient {
        let configuration = ClientConnection.Configuration(
            target: .hostAndPort(host, port),
            eventLoopGroup: eventLoopGroup,
            tls: .init()
        )
        let connection = ClientConnection(configuration: configuration)
        return Google_Cloud_Texttospeech_V1_TextToSpeechServiceClient(connection: connection)
    }
}
