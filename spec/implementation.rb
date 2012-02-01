$LOAD_PATH.unshift File.expand_path("#{File.dirname(__FILE__)}/../commonwatir/lib")
$LOAD_PATH.unshift File.expand_path("#{File.dirname(__FILE__)}/../watir/lib")
$LOAD_PATH.unshift File.expand_path("#{File.dirname(__FILE__)}/../firewatir/lib")

require "watir"

WatirSpec.implementation do |imp|
  imp.name = :watir

  if ENV['watir_browser'] =~ /firefox/
    imp.browser_class = FireWatir::Firefox
    browser = :firefox
  else
    WatirSpec.persistent_browser = false
    imp.browser_class = Watir::IE
    browser = :ie
    browser_version = (ENV['watir_browser_version'] || :ie8).to_sym
  end

  imp.guard_proc = lambda { |args|
    args.any? {|arg| arg == :watir || arg == [:watir, browser] || arg == :ie || arg == browser_version}
  }
end

include Watir
include Watir::Exception
