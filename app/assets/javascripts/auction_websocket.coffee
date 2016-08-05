(($) ->
  # define Auction socket Init
  class @AuctionSocket
    constructor: ->
      protocol = ' ws://'
      if (location.protocol == "https:")
        protocol = "wss://"
      hostname = location.hostname
      port = ':' + location.port
      if (location.port == "undefined" || location.port == '')
        port = ''
      @socket =  new WebSocket(protocol + hostname + port);
      self = @
      @socket.onmessage = (e) ->
        console.log e
        data = ""
        try
          data = JSON.parse e.data
        catch e
          console.info e
        switch data.message
          when 'bidok'  then  self.bid(data)
          when 'outbid' then  self.outbid(data)
          when 'won'    then  self.won(data)
          when 'createrobotok' then  self.createrobot(data)
          when 'lost' then  self.lost(data)
          else  console.info data

    # Auction socket Send Message function
    sendBid: (user_id, auction_id) ->
      template = {"action": 'bid', "auction_id" : '{{auction_id}}', "user_id" : '{{user_id}}'}
      @socket.send Mustache.render(JSON.stringify(template), {user_id: user_id, auction_id: auction_id})

    # Auction create robot function
    createRobotSocket: (template,user_id, auction_id) ->
      @socket.send Mustache.render(JSON.stringify template , {user_id: user_id, auction_id: auction_id})

    # Auction bid function to update informations
    bid: (data) ->
      $('.messunits').html(data.units+ 'Unités')
      $('.nbench').html(data.ench+ ' Enchères')
      user_id =  parseInt(sessionStorage.getItem('ours'))
      if(data.user_id == user_id)
        $('#infogagn').html('Félicitations ,vous êtes temporairement le gagnant.')
      else
        $('#infogagn').html('Ooopss. Vous êtes hors enchère en ce moment.')

      $('.desprice').html(data.value + 'FCFA')
      $('#infogagn').addClass('infogagn_inverse').removeClass('infogagn')

      $('.infogagn_inverse').animateinfogagn('wobble')

      $('.desprice').addClass('desprice_inverse').removeClass('desprice')

      $('.desprice_inverse').animateCss('pulse')
      if(data.disable_robot_id != undefined && data.disable_robot_id != null)
        $("#robot_" + data.disable_robot_id).bootstrapSwitch('state', false, false)
        $("#conteur_" + data.disable_robot_id).addClass("hide")
        $("#send_bid_btn").prop('disabled', true)

# Auction outbid function update informations
    outbid: (data) ->
      $('.nbench').html(data.ench+ ' Enchères')
      user_id =   parseInt(sessionStorage.getItem('ours'))
      if(data.user_id == user_id)
        $('#infogagn').html('Félicitations ,vous êtes temporairement le gagnant.')
      else
        $('#infogagn').html('Ooopss. Vous êtes hors enchère en ce moment.')

      $('.desprice').html(data.value + 'FCFA')
      $('#infogagn').addClass('infogagn_inverse').removeClass('infogagn')
      $('.infogagn_inverse').animateinfogagn('wobble')
      $('.desprice').addClass('desprice_inverse').removeClass('desprice')
      $('.desprice_inverse').animateCss('pulse')

      if(data.disable_robot_id != "undefined" && data.disable_robot_id != null)
        $("#robot_"+data.disable_robot_id).bootstrapSwitch('state', false, false)
        $("#conteur_"+data.disable_robot_id).addClass("hide")
        $("#send_bid_btn").prop('disabled', false)


    # Auction create robot funcrtion update robot form
    createrobot: (data) ->
      $(".robot-config-area").addClass("hide")
      $("#send_bid_btn").prop('disabled', true)
      $("#conteur_"+data.user_id+""+data.auction_id).removeClass("hide")
      $("#conteur_"+data.user_id+""+data.auction_id).find('div').attr('data-countdown',data.robot_ends_at)
      $this = $("#conteur_"+data.user_id+""+data.auction_id).find('div')
      finalDate = $("#conteur_"+data.user_id+""+data.auction_id).find('div').data('countdown')
      $this.countdown finalDate,(event) ->
        $this.html(event.strftime('<span class="cdown days"><span class="time-count">%-D<span>J</span></span></span><span class="cdown hour"><span class="time-count">%-H<span>H</span></span></span><span class="cdown minutes"><span class="time-count">%M<span>M</span></span></span> <span class="cdown second"><span class="time-count">%S<span>S</span></span></span>'))

  # JQUERY EXTEND ANIMATION FUNCTION
  $.fn.extend {
    animateinfogagn:  (animationName) ->
      animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
      $(this).addClass('animated ' + animationName).one animationEnd, ->
        $(this).removeClass('animated ' + animationName)
        $(this).addClass('infogagn').removeClass('infogagn_inverse')

    animateCss: (animationName) ->
      animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
      $(this).addClass('animated ' + animationName).one animationEnd, ->
        $(this).removeClass('animated ' + animationName)
        $(this).addClass('desprice').removeClass('desprice_inverse')
  }
    
) jQuery