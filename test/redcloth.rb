require 'rubygems'
require 'RedCloth'

puts RedCloth.new("h2. Test document
    
    Just a simple test.").to_html
