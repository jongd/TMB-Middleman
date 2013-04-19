require File.expand_path("../rack_static_cache", __FILE__)
require File.expand_path("../rack_try_static", __FILE__)

use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == 'meteor' && password == 'book'
end

use ::Rack::TryStatic,
  :root => "build",
  :urls => ["/"],
  :try  => [".html", "index.html", "/index.html"]
 

use Rack::StaticCache, :urls => ["/images", "/stylesheets", "/javascripts"], :root => "build"

run lambda { |env| [404, {"Content-Type" => "text/plain"}, ["File not found!"]] }
