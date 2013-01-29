require 'rubygems'
require 'test/unit'
require 'RedCloth'
require 'html2textile'

class ConvertTextileToHtmlTest < Test::Unit::TestCase

  def test_wysiwygtextiletohtml

    puts "\n============================="
    puts "Textile to HTML tests.\n"
    puts "=============================\n"

    # Test 1
    textiletittle = "h2. Test document"
    
    doc = RedCloth.new(textiletittle)
    
    textiletittle_html = doc.to_html
    
    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 1\n"
    puts "-----------------------------\n"

    puts "Convert textile title:\n"+textiletittle+"\nto Html tittle:\n" + textiletittle_html

    assert true

    # Test 2
    textileimage = "!http://www.textism.com/common/textist.gif(Textism)!"

    doc = RedCloth.new(textileimage)
    
    textileimage_html = doc.to_html

    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 2\n"
    puts "-----------------------------\n"
    
    puts "Convert textile image:\n"+textileimage+"\nto Html image source:\n" + textileimage_html

    assert true

    # Test 3
    textileblock = "
h3. Solution to redmine_wysiwyg_textile

Downloading @prototype.js@ into @/redmine_wysiwyg_textile/assets/javascripts/prototype@ directory:

* wget https://ajax.googleapis.com/ajax/libs/prototype/1.7.1.0/prototype.js

Adding to @helper.rb@ file *prototype.js* library (inside _wikitoolbar_for_wysiwyg_ method):

* javascript_include_tag('prototype.js', :plugin => 'redmine_wysiwyg_textile') + 

Makes *Ajax.Request* call. \"wiki plugin forum\":http://www.redmine.org/boards/3/topics/17852?r=34841#message-34841

No funciona como lo esperado ya que no llega a convertir *html to textile*. fail.

h3. TODO

Migrate \"redmine_conv_htmltotextile\":https://github.com/Godhart/redmine_conv_htmltotextile and test using \"redmine guide\":http://www.redmine.org/boards/3/topics/31445.
"

    doc = RedCloth.new(textileblock)
    
    textileblock_html = doc.to_html

    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 3\n"
    puts "-----------------------------\n"
    
    puts "Convert textile block:\n"+textileblock+"\nto Html block source:\n" + textileblock_html

    assert true
    
  end

end