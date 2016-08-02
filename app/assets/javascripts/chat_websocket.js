var ChatSocket = function(user_id, form) {
  this.user_id = user_id;
  this.form = $(form);

  this.socket = new WebSocket(App.websocket_url + 'chat');

  this.initMessages();
};

ChatSocket.prototype.initMessages = function() {
  var _this = this;

  this.form.submit(function(e) {
    e.preventDefault();
    _this.sendMessage();
  });

  this.socket.onmessage = function(e) {
      var data ="";
      try {
          data = JSON.parse(e.data);

      }catch (e){
          console.log(e);
      }


      switch(data.action) {
      case 'chat':
        _this.chat( data.message);
        break;
      case 'chatnotifother':
          _this.chatnotifother();
      break;

    }
    console.log(e);
  };

    return false;
};

ChatSocket.prototype.sendMessage = function() {
    var template = {"action": 'chat', "user_id" : '{{user_id}}', "message" : '{{message}}'};
    this.socket.send(Mustache.render(JSON.stringify(template), {
        user_id: this.user_id,
        message: $("#comment_body").val()
    }));
};


ChatSocket.prototype.chat = function(message) {
    $.ajax({
        type: "POST",
        url: '/comments',
        data: JSON.stringify({
            "body" : message
        }),
        contentType: 'application/json',
        dataType: 'json', // format of the response
        success: function(msg) {

        }
      });

}



ChatSocket.prototype.chatnotifother = function () {

}
