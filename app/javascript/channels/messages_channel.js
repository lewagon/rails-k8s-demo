import consumer from "./consumer"

// With turbolinks, this listener must be used
document.addEventListener("turbolinks:load", function() {
  consumer.subscriptions.create("MessagesChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log("Hello from AC")
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
      console.log("Goodbye from AC")
    },

    received(data) {
      // Called when there's incoming data on the websocket for this channel
    }
  });
});
