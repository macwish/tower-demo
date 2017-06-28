//= require event

'use strict';


$(function(){

  const eventHandler = new App.EventHandler('#event-list');

  App.pushChannel = App.cable.subscriptions.create({
    channel: 'PushChannel',
    token: 'my_client_token_xxxx'
  }, {
    connected: function() {
      console.log('[AC][Push] connected');
    },
    disconnected: function(notify) {
      console.log('[AC][Push] disconnected', notify);
    },
    received: function(data) {
      console.log('[AC][Push] received data: ', data);

      switch (data.type) {
        case 'Event':
          eventHandler.handleEvent(data);
        break;
        default:
          console.error('[AC][Push] unknown data.type. ', data)
        break;
      }
    }
  })
});