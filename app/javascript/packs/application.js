require("@rails/ujs").start();
require("turbolinks").start();

import "controllers";
import "../stylesheets/application";

// https://css-tricks.com/the-trick-to-viewport-units-on-mobile/
let vh = window.innerHeight * 0.01;
document.documentElement.style.setProperty("--vh", `${vh}px`);
