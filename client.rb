# frozen_string_literal: true

require 'async'
require 'async/io/stream'
require 'async/http/endpoint'
require 'async/websocket/client'

module Client
  URL = 'https://localhost:9292'
  ENDPOINT = Async::HTTP::Endpoint.parse URL
  MESSAGE = ARGV.first || 'ping'

  module_function

  def call
    Async do |_task|
      Async::WebSocket::Client.connect ENDPOINT do |connection|
        puts "Sending message: #{MESSAGE}"
        connection.write MESSAGE
        connection.flush

        while message = connection.read
          puts "Receiving message: #{message.to_str}"
        end
      end
    end
  end
end

Client.call
