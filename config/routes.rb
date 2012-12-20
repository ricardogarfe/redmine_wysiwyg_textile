#custom routes for this plugin
RedmineApp::Application.routes.draw do

    match "#{Redmine::Utils.relative_url_root}/convert/wysiwygtohtmltotextile", :via => [:post, :put]
    match "#{Redmine::Utils.relative_url_root}/convert/wysiwygtotextiletohtml", :via => [:post, :put]

end
