#
# Redmine Wysiwyg Textile Editor
#
# P.J.Lawrence October 2010
#
require 'redmine'

# ActiveSupport::Dependencies.explicitly_unloadable_constants << 'RedmineWysiwygTextile'
# ActiveSupport::Dependencies.autoload_once_paths.delete(File.expand_path(File.dirname(__FILE__))+'/plugins')

def logger
  Logger.new(STDERR)
end
logger.info 'Starting Wysiwyg Textile for Redmine'

Redmine::Plugin.register :redmine_wysiwyg_textile do
    name 'Redmine Wysiwyg Textile'
    author 'P.J. Lawrence'
    description 'A TinyMCE test application for Textile wiki pages'
    version '0.14'
    
    wiki_format_provider 'textile wysiwyg', RedmineWysiwygTextile::WikiFormatter, \
                                             RedmineWysiwygTextile::Helper
end








