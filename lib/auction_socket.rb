class AuctionSocket

    def initialize app
      @app = app
    end

    def call env
      @env = env
      if socket_request?
          socket = spawn_socket
          socket.rack_response
      else
        @app.call env
      end
    end

    private

    attr_reader :env

    def socket_request?
        Faye::WebSocket.websocket? env
    end

    def spawn_socket
        socket = Faye::WebSocket.new env

        socket.on :open do
            socket.send "Hello"
        end

        socket.on :message do |event|
            socket.send event.data
        end

        socket
    end
end
