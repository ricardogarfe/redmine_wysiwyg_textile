#custom routes for this plugin
RedmineApp::Application.routes.draw do
  match "/convert/wysiwygtohtmltotextile" => "convert#wysiwygtohtmltotextile", :via => [:post, :put, :get]
  match "/convert/wysiwygtotextiletohtml" => "convert#wysiwygtotextiletohtml", :via => [:post, :put, :get]
end
