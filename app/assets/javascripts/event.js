//= require helper

'use strict';

(function(module) {
  
  const EventHandler = function(selector) {
    this.container = $(selector);
  }

  EventHandler.prototype.handleEvent = function(event) {

    const type    = event.type;
    const id      = event.id;
    const content = event.content;

    if (type !== 'Event') {
      console.error('[Event] not a "Event" type: ', type);
      return;
    }
    if (typeof id !== 'number') {
      console.error('[Event] invalid event.id: ', event);
      return;
    }
    
    this.appendEventContent(id, content);
  }

  EventHandler.prototype.appendEventContent = function(eventId, eventEontent) {
    this.container.prepend(eventEontent);
    App.Helper.blink(this.eventElementSelector(eventId));
  }

  EventHandler.prototype.eventElementSelector = function(eventId) {
    return '[data-event-id='+eventId+']'
  }
  
  // 
  module.EventHandler = EventHandler;

})(App);
