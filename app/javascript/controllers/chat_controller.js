import { Controller } from "stimulus";
import consumer from "channels/consumer";

function subscribeConsumerWithStimulusContext(ctx) {
  consumer.subscriptions.create("MessagesChannel", {
    connected() {
      console.log("Hello from AC");
    },

    disconnected() {
      console.log("Goodbye from AC");
    },

    received(message) {
      console.log(message);
      ctx.insertMessage(message);
      ctx.clearForm();
    }
  });
}

export default class extends Controller {
  static targets = ["messages", "form"];

  connect() {
    console.log("Stimulus chat controller up");
    subscribeConsumerWithStimulusContext(this);
  }

  insertMessage(message) {
    this.messagesTarget.insertAdjacentHTML("afterbegin", message.html);
  }

  insertPreview(preview) {}

  clearForm() {
    this.formTarget.reset();
  }
}
