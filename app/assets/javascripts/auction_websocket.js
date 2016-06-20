var AuctionSocket = function(user_id, auction_id, form) {
  this.user_id = user_id;
  this.auction_id = auction_id;
  this.form = $(form);

  this.socket = new WebSocket(App.websocket_url + 'auctions/' + this.auction_id);

  this.initBinds();
};

AuctionSocket.prototype.initBinds = function() {
  var _this = this;

  this.form.submit(function(e) {
    e.preventDefault();
    _this.sendBid();
  });

  this.socket.onmessage = function(e) {

    var tokens = e.data.split(' ');

    switch(tokens[0]) {
      case 'bidok':
        _this.bid(tokens[1], tokens[2], tokens[3]);
        break;
      case 'underbid':
        _this.underbid(tokens[1]);
        break;
      case 'outbid':
        _this.outbid(tokens[1]);
        break;
      case 'won':
        _this.won();
        break;
      case 'lost':
        _this.lost();
        break;
    }
    console.log(e);
  };
};

AuctionSocket.prototype.sendBid = function() {
  var template = "bid {{auction_id}} {{user_id}}";
  this.socket.send(Mustache.render(template, {
    user_id: this.user_id,
    auction_id: this.auction_id
  }));
};

AuctionSocket.prototype.bid = function(value,units) {
     $('.messunits strong').html(
    'Il vous reste: ' +units+ ' unités');

    this.form.find('.message strong').html(
        'Your bid: ' + value
    );

};

AuctionSocket.prototype.underbid = function(value) {
  this.form.find('.message strong').html(
    'Your bid is under ' + value + '.'
  );
};

AuctionSocket.prototype.outbid = function(value) {
  this.form.find('.message strong').html(
    'You were outbid. It is now ' + value + '.'
  );
};
