// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from '@rails/ujs';
// import Turbolinks from 'turbolinks';
import * as ActiveStorage from '@rails/activestorage';
import 'channels';
import 'bootstrap/dist/js/bootstrap';
import '../stylesheets/application.scss';

import '@fortawesome/fontawesome-free/js/solid.js';
import '@fortawesome/fontawesome-free/js/regular.js';
import '@fortawesome/fontawesome-free/js/fontawesome.js';

import '@hotwired/turbo-rails';
// TODO: change to opt-in strategy?
// import { Turbo } from '@hotwired/turbo-rails';
// Turbo.session.drive = false;

Rails.start();
// Turbolinks.start();
ActiveStorage.start();

const images = require.context("../images", true)
// const imagePath = name => images(name, true)
