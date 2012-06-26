#custom routes for this plugin
RedmineApp::Application.routes.draw do

    match "convert/wysiwygtohtmltotextile", :via => [:post, :put]
    match "convert/wysiwygtotextiletohtml", :via => [:post, :put]

end