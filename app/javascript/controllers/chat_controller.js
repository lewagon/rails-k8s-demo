import { Controller } from "stimulus";
import consumer from "channels/consumer";

function subscribeConsumerWithStimulusContext(ctx) {
  consumer.subscriptions.create("MessagesChannel", {
    connected() {
      console.log("Hello from AC!");
    },

    disconnected() {
      console.log("Goodbye from AC");
    },

    received(message) {
      switch (message.type) {
        case "message":
          console.log(message);
          ctx.insertMessage(message);
          ctx.clearForm(message.author);
          break;
        case "preview":
          console.log(message);
          ctx.insertPreview(message);
          break;
      }
    }
  });
}

export default class extends Controller {
  static targets = ["messages", "form"];

  connect() {
    console.log("Stimulus chat controller up");
    subscribeConsumerWithStimulusContext(this);
    this.messagesTarget.lastElementChild.scrollIntoView();
  }

  insertMessage(message) {
    this.messagesTarget.insertAdjacentHTML("beforeend", message.html);
    const username = this.data.get("username");
    const lastMessageRow = document.getElementById(`message-${message.id}`)
      .parentElement;
    if (message.author == username) {
      lastMessageRow.classList.replace("flex-row", "flex-row-reverse");
    }
    lastMessageRow.scrollIntoView();
  }

  insertPreview(preview) {
    const message = document.getElementById(`message-${preview.message_id}`);
    if (message) {
      const previews = message.querySelector(".previews");
      previews.insertAdjacentHTML("afterbegin", preview.html);
      message.scrollIntoView();
    }
  }

  clearForm(author) {
    if (author === this.data.get("username")) {
      this.formTarget.reset();
    }
  }
}
