#custom routes for this plugin
RedmineApp::Application.routes.draw do

    match "redmine/convert/wysiwygtohtmltotextile", :via => [:post, :put]
    match "redmine/convert/wysiwygtotextiletohtml", :via => [:post, :put]

end
