require File.expand_path "../place_bid", __FILE__

class ActivateRobot
  attr_reader :auction, :is_active, :user, :ends_at , :units, :id
  def create options
    #init components
    @user_id = options[:user_id].to_i
    @auction_id = options[:auction_id].to_i
    @ends_at = Time.now + options[:ends_at].to_i.seconds
    @units = options[:units].to_i
    @is_active = options[:is_active]
    p @is_active, ".........................................1"
    @id =  (options[:user_id].to_s + options[:auction_id].to_s).to_i


    @auction = Auction.find @auction_id
    @user = User.find @user_id
    @robot = Robot.where(id: id).first
    if @robot.nil?
      @robot = Robot.new
      @robot.is_active = true
    else
      if @ends_at < Time.now || !@is_active
        @robot.is_active =  false
      else
        @robot.is_active = true
      end
    end

    p  @user.units >= @units, ".............................c1"
    p  !@auction.ended?, ".............................c2"
    p  @robot.is_active , ".............................c3"
    p  @units > 2, ".............................c4"

    if @user.units >= @units && !@auction.ended? &&   @robot.is_active && @units > 2
      @robot.id = (@user.id.to_s + @auction.id.to_s).to_i
      @robot.user = @user
      @robot.auction = @auction

      @robot.units = @units
      p @robot.to_s, ".........................................2"
      user.units -= @units
      @robot.ends_at = @ends_at

      @value = @auction.value
      @units = user.units
      @auction_close = auction.auction_close

      ActiveRecord::Base.transaction do
        auction.save
        user.save
      end

      p @robot.to_s, ".........................................3"
      if @robot.save
        if @user_id != @auction.top_bid.user_id
          service = PlaceBid.new
          service.robot @robot
        end
        return true
      else
        return false
      end
    else
      @robot.save
      return false
    end
  end

end
