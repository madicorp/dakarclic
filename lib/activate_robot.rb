require File.expand_path "../place_bid", __FILE__
class ActivateRobot
  def initialize app
    @app = app
    @clients = []
  end

  def call env
    @env = env
    if socket_request?
      socket = spawn_socket
      @clients << socket
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
      socket.send "Socket open!"
    end

    socket.on :message do |event|
      socket.send event.data
      begin
        tokens = event.data.split " "
        operation = tokens.delete_at 0

        case operation
          when "bid"
            bid socket, tokens
        end

      rescue Exception => e
        p e
        p e.backtrace
      end
    end

    socket
  end
end