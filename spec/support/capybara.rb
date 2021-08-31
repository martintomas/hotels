# frozen_string_literal: true

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu no-sandbox window-size=1440x768]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :headless_chrome
    Capybara.ignore_hidden_elements = false
  end
end
