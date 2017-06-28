'use strict';

(function(module) {
  
  const Helper = {
    
    // blink animation
    blink: function(selector, completed = (function(sel){}) ) {
      const sel = (selector instanceof jQuery) ? selector : $(selector);
      const original = sel.css('background-color');
      sel.css({'background-color': '#f3df43'})
         .animate({'background-color': original}, 1000, function(){
           (typeof completed === 'function') && completed(sel);
        });
    }
  }

  // 
  module.Helper = Helper;

})(App);
