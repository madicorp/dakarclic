
class ChatSocket
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
            socket.send "Socket Chat open!"
        end

        socket.on :message do |event|
            socket.send event.data
            begin
                message = ActiveSupport::JSON.decode(event.data)
                #tokens = event.data.split " "
                case message["action"]
                    when "chat"
                        chat socket, message
                end

            rescue Exception => e
                p e
                p e.backtrace
            end
        end

        socket
    end

    def chat socket, message
        service = PlaceComment.new

        # if service.execute user_id: message['user_id'], message: message['message']
        reponse = {
            :action => 'chat',
            :user_id => message['user_id'],
            :message => message['message']
        }.to_json
        socket.send reponse
        notify_other socket, message
        # end
    end

  def notify_other socket , message
      puts  @clients.size + "dfkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
      @clients.reject { |client| client == socket  }.each do |client|
          reponse = {
              :action => 'chatnotifother'
          }.to_json
          client.send reponse
      end
  end

end
