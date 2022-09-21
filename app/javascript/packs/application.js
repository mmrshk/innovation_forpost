require("@rails/ujs").start()
import "@hotwired/turbo-rails";
require("@rails/activestorage").start()
require("channels")

import 'materialize-css/dist/js/materialize'
import './scripts/scroll'
import './ckeditor_embed_snippet'
import './accordions'
import './active_button'
import './limit_records'
import './load_more'

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
