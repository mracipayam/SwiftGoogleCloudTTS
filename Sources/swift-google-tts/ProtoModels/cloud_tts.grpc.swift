//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: google/cloud/texttospeech/v1/cloud_tts.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import GRPC
import NIO
import NIOHTTP1
import SwiftProtobuf


/// Usage: instantiate Google_Cloud_Texttospeech_V1_TextToSpeechServiceClient, then call methods of this protocol to make API calls.
public protocol Google_Cloud_Texttospeech_V1_TextToSpeechService {
  func listVoices(_ request: Google_Cloud_Texttospeech_V1_ListVoicesRequest, callOptions: CallOptions?) -> UnaryCall<Google_Cloud_Texttospeech_V1_ListVoicesRequest, Google_Cloud_Texttospeech_V1_ListVoicesResponse>
  func synthesizeSpeech(_ request: Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest, callOptions: CallOptions?) -> UnaryCall<Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest, Google_Cloud_Texttospeech_V1_SynthesizeSpeechResponse>
}

public final class Google_Cloud_Texttospeech_V1_TextToSpeechServiceClient: GRPCClient, Google_Cloud_Texttospeech_V1_TextToSpeechService {
  public let connection: ClientConnection
  public var defaultCallOptions: CallOptions

  /// Creates a client for the google.cloud.texttospeech.v1.TextToSpeech service.
  ///
  /// - Parameters:
  ///   - connection: `ClientConnection` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  public init(connection: ClientConnection, defaultCallOptions: CallOptions = CallOptions()) {
    self.connection = connection
    self.defaultCallOptions = defaultCallOptions
  }

  /// Asynchronous unary call to ListVoices.
  ///
  /// - Parameters:
  ///   - request: Request to send to ListVoices.
  ///   - callOptions: Call options; `self.defaultCallOptions` is used if `nil`.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func listVoices(_ request: Google_Cloud_Texttospeech_V1_ListVoicesRequest, callOptions: CallOptions? = nil) -> UnaryCall<Google_Cloud_Texttospeech_V1_ListVoicesRequest, Google_Cloud_Texttospeech_V1_ListVoicesResponse> {
    return self.makeUnaryCall(path: "/google.cloud.texttospeech.v1.TextToSpeech/ListVoices",
                              request: request,
                              callOptions: callOptions ?? self.defaultCallOptions)
  }

  /// Asynchronous unary call to SynthesizeSpeech.
  ///
  /// - Parameters:
  ///   - request: Request to send to SynthesizeSpeech.
  ///   - callOptions: Call options; `self.defaultCallOptions` is used if `nil`.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func synthesizeSpeech(_ request: Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest, callOptions: CallOptions? = nil) -> UnaryCall<Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest, Google_Cloud_Texttospeech_V1_SynthesizeSpeechResponse> {
    return self.makeUnaryCall(path: "/google.cloud.texttospeech.v1.TextToSpeech/SynthesizeSpeech",
                              request: request,
                              callOptions: callOptions ?? self.defaultCallOptions)
  }

}

/// To build a server, implement a class that conforms to this protocol.
public protocol Google_Cloud_Texttospeech_V1_TextToSpeechProvider: CallHandlerProvider {
  func listVoices(request: Google_Cloud_Texttospeech_V1_ListVoicesRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Google_Cloud_Texttospeech_V1_ListVoicesResponse>
  func synthesizeSpeech(request: Google_Cloud_Texttospeech_V1_SynthesizeSpeechRequest, context: StatusOnlyCallContext) -> EventLoopFuture<Google_Cloud_Texttospeech_V1_SynthesizeSpeechResponse>
}

extension Google_Cloud_Texttospeech_V1_TextToSpeechProvider {
  public var serviceName: String { return "google.cloud.texttospeech.v1.TextToSpeech" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handleMethod(_ methodName: String, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
    switch methodName {
    case "ListVoices":
      return UnaryCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.listVoices(request: request, context: context)
        }
      }

    case "SynthesizeSpeech":
      return UnaryCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.synthesizeSpeech(request: request, context: context)
        }
      }

    default: return nil
    }
  }
}
