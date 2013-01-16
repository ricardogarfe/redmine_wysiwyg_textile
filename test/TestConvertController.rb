require 'rubygems'
require 'test/unit'
require 'RedCloth'
require 'html2textile'

class ConvertControllerTest < Test::Unit::TestCase

  def no_test_wysiwygtextiletohtml

    puts "\n============================="
    puts "Textile to HTML tests.\n"
    puts "=============================\n"

    # Test 1
    textiletittle = "h2. Test document"
    
    doc = HTMLFormatter.new(textiletittle)
    
    textiletittle_html = doc.to_html
    
    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 1\n"
    puts "-----------------------------\n"

    puts "Convert textile title:\n"+textiletittle+"\nto Html tittle:\n" + textiletittle_html

    assert true

    # Test 2
    textileimage = "!http://www.textism.com/common/textist.gif(Textism)!"

    doc = HTMLFormatter.new(textileimage)
    
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

    doc = HTMLFormatter.new(textileblock)
    
    textileblock_html = doc.to_html

    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 3\n"
    puts "-----------------------------\n"
    
    puts "Convert textile block:\n"+textileblock+"\nto Html block source:\n" + textileblock_html

    assert true
    
  end
  
  def test_wysiwyghtmltotextile

    puts "\n============================="
    puts "HTML to Textile tests.\n"
    puts "=============================\n"

    # Test 1
    htmltittle = "<h2>Test document</h2>"

    parser = HTMLToTextileParser.new
    parser.feed(htmltittle)
    htmltittle_textile = parser.to_textile

    puts "\n-----------------------------"
    puts "wysiwyghtmltotextile Test 1\n"
    puts "-----------------------------\n"

    puts "Convert Html tittle:\n"+htmltittle+"\nto textile tittle source:\n" + htmltittle_textile

    assert true

    # Test 2
    htmlimage = "<img src=\"http://www.textism.com/common/textist.gif\" title=\"Textism\" alt=\"Textism\" />"

    parser = HTMLToTextileParser.new
    parser.feed(htmlimage)
    htmlimage_textile = parser.to_textile

    puts "\n-----------------------------"
    puts "wysiwyghtmltotextile Test 2\n"
    puts "-----------------------------\n"

    puts "Convert Html image:\n"+htmlimage+"\nto textile image source:\n" + htmlimage_textile

    assert true

    # Test 3
    htmllink = "<a href=\"http://jystewart.net/process/tag/conversion/\" rel=\"tag\">conversion</a>"

    parser = HTMLToTextileParser.new
    parser.feed(htmllink)
    htmllink_textile = parser.to_textile

    puts "\n-----------------------------"
    puts "wysiwyghtmltotextile Test 3\n"
    puts "-----------------------------\n"

    puts "Convert Html link:\n"+htmllink+"\nto textile link source:\n" + htmllink_textile

    assert true

    # Test 4
    htmlblock = "
<h3>Solution to redmine_wysiwyg_textile</h3>
<p>Downloading <code>prototype.js</code> into <code>/redmine_wysiwyg_textile/assets/javascripts/prototype</code> directory:</p>
<ul>
  <li>wget https://ajax.googleapis.com/ajax/libs/prototype/1.7.1.0/prototype.js</li>
</ul>
<p>Adding to <code>helper.rb</code> file <strong>prototype.js</strong> library (inside <em>wikitoolbar_for_wysiwyg</em> method):</p>
<ul>
  <li>javascript_include_tag(&#8216;prototype.js&#8217;, :plugin =&gt; &#8216;redmine_wysiwyg_textile&#8217;) +</li>
</ul>
<p>Makes <strong>Ajax.Request</strong> call. <a href=\"http://www.redmine.org/boards/3/topics/17852?r=34841#message-34841\">wiki plugin forum</a></p>
<p>No funciona como lo esperado ya que no llega a convertir <strong>html to textile</strong>. fail.</p>
<h3><span class=\"caps\">TODO</span></h3>
<p>Migrate <a href=\"https://github.com/Godhart/redmine_conv_htmltotextile\">redmine_conv_htmltotextile</a> and test using <a href=\"http://www.redmine.org/boards/3/topics/31445\">redmine guide</a>.</p>
"

    parser = HTMLToTextileParser.new
    parser.feed(htmlblock)
    htmlblock_textile = parser.to_textile

    puts "\n-----------------------------"
    puts "wysiwygtextiletohtml Test 4\n"
    puts "-----------------------------\n"
    
    puts "Convert html block:\n"+htmlblock+"\nto textile block source:\n" + htmlblock_textile

    assert true
  end

end