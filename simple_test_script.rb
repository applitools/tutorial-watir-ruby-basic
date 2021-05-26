require 'eyes_selenium'
require 'watir'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless') if ENV['CI'] == 'true'

runner = Applitools::ClassicRunner.new
eyes = Applitools::Selenium::Eyes.new(runner: runner)
browser = Watir::Browser.new(:chrome, options:options)
Applitools::EyesLogger.log_handler = Logger.new(STDOUT).tap do |l|
  l.level = Logger::INFO
end

sconf = Applitools::Selenium::Configuration.new.tap do |conf|
  conf.api_key = ENV['APPLITOOLS_API_KEY']
  conf.app_name = 'Demo App - Watir'
  conf.test_name = 'Ruby Watir demo'
  conf.viewport_size = Applitools::RectangleSize.new(800, 600)
end

eyes.config = sconf

begin
  # Call Open on eyes to initialize a test session
  driver = eyes.open(driver: browser.driver)

  # Navigate to the url we want to test
  driver.get('https://demo.applitools.com/index.html')

  # Note to see visual bugs, run the test using the above URL for the 1st run.
  # but then change the above URL to https://demo.applitools.com/index_v2.html (for the 2nd run)

  # check the login page
  eyes.check('Login page', Applitools::Selenium::Target.window.fully)

  # Click the 'Log In' button
  driver.find_element(:id, 'log-in').click

  # Check the app page
  eyes.check('App Page', Applitools::Selenium::Target.window.fully)
  eyes.close
ensure
  # Close the browser
  driver.quit
  eyes.abort
  # Get and print all test results
  puts runner.get_all_test_results
end


