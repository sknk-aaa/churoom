# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "hamburger", to: "hamburger.js"
pin "mode-select", to: "mode-select.js"
# pin_all_from "app/javascript", under: "."
pin_all_from "app/javascript/controllers", under: "controllers"
pin "lodash" # @4.17.21
