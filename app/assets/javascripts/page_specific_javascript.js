// Run page specific javascript using data attributes 'controller' and 'action' on the body. Page-specific functions are
// stored in the 'APP' variable, which is populated by scripts in /app. For a script that runs on the Budget controller
// home action, the code should be defined as:
//
// APP.budget = {
//   show: function() {
//     // Do something
//   }
// }

APP = {};

UTIL = {
  init: function() {
    var controller = document.body.getAttribute("data-controller"),
        action = document.body.getAttribute("data-action");

    UTIL.runCode(controller, 'init');
    UTIL.runCode(controller, action);
  },

  runCode: function(controller, action) {
    if( APP[controller] && typeof APP[controller][action] == "function" ) {
      APP[controller][action]();
    }
  }
};

// Run code on page:change - this fires on document-ready as well as any subsequent page loads
$(document).on('turbolinks:load', UTIL.init);
