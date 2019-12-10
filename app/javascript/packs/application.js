require("@rails/ujs").start();
require("turbolinks").start();

import "controllers";
import "../stylesheets/application";

// get the actual viewport height on mobile browsers
window.addEventListener("DOMContentLoaded", event => {
  const chat = document.querySelector("#chat");
  const messagesContainer = document.querySelector("#messages-container");
  const viewPortH = chat.getBoundingClientRect().height;
  const windowH = window.innerHeight;
  const browserUiBarsH = viewPortH - windowH;
  chat.style.height = `calc(100vh - ${browserUiBarsH}px)`;
  messagesContainer.style.height = `calc(70vh - ${browserUiBarsH}px)`;
});
