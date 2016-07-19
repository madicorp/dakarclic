require File.expand_path "../place_bid", __FILE__

class AuctionSocket
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
                        @auction = Auction.find  tokens[0].to_i
                        @robots = @auction.active_robots
                        @robots.each do |robot|
                            tokens[2] = robot.id
                            active_robot socket, tokens
                            p robot.id, "000000000000000000000"
                        end
                end

            rescue Exception => e
                p e
                p e.backtrace
            end
        end

        socket
    end

    def bid socket, tokens
        service = PlaceBid.new
        if service.execute auction_id: tokens[0],  user_id: tokens[1]
            socket.send "bidok #{service.value} #{service.units} #{service.nb_ench} 1 #{service.user.id}, -1"
            notify_outbids socket, service.value , service.nb_ench, service.user.id , -1
        else
            if service.status == :won
                notify_auction_ended socket
            end
        end
    end

    def active_robot socket, tokens
        service = PlaceBid.new
        @robot = Robot.find tokens[2]
        if service.robot @robot
            socket.send "bidok #{service.value} #{service.units} #{service.nb_ench} 1 #{service.user.id} #{service.units_robot}"
            notify_outbids socket, service.value , service.nb_ench, service.user.id , service.units_robot
        else
            if service.status == :won
                notify_auction_ended socket
            end
        end
    end

    def notify_outbids socket, value , nb_ench, user ,units_robot
        @clients.reject { |client| client == socket || !same_auction?(client,socket) }.each do |client|
            client.send "outbid #{value} #{nb_ench} #{user} #{units_robot}"
        end
    end

    def notify_auction_ended socket
        socket.send "won"

        @clients.reject { |client| client == socket || !same_auction?(client,socket) }.each do |client|
            client.send "lost"
        end
    end

    def same_auction? other_socket, socket
        other_socket.env["REQUEST_PATH"] == socket.env["REQUEST_PATH"]
    end

end
