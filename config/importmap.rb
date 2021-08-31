Rails.application.config.importmap.draw do


  pin "@hotwired/turbo-rails", to: "turbo.js"

  pin "@hotwired/stimulus", to: "stimulus.js"
  pin_all_from "app/assets/javascript/controllers", under: "controllers"

  pin "application"
end
