Redmine Wysiwyg Textile Editor
===============================

A TinyMCE test application for Textile wiki pages.

Currently this is a test version for in-house use only since there is a few issues that need to be sorted out regarding the conversion to and from textile and other security issues. If you stick to simple textile formatting it's not a problem, but when it comes to images and macros that's another issue.

A better option would be to write a javascript wysiwyg editor for redmine like the one used in Trac. 

Installation
------------

1. Copy the plugin directory into the plugins directory (make sure the name is redmine_wysiwyg_textile)
2. Start Redmine
3. Change text formatting (Administration > Settings > General > Text formatting) to "textile wysiwyg"
                    
Usage
-----

When editing a wiki page a radio button will be displayed below the Save button. This radio button allows the user to switch between the standard redmine textile editor and the tinymce wysiwyg editor.

Requirements
-------------

Install required gems:

* test/unit
* RedCloth
* html2textile

Using gem install command:

	gem install <gem-name>

Test
-----

Tests are placed in ``test`` directory. Using Unittest gem to check features and debug conversion errors.

* TestConvertController.rb: this is the main test.

The other files are only test samples to learning how to test in ruby.
 
History
--------

* 12 Oct 2010 - v0.11 - fixed bug related to saving raw html in Wysiwyg mode.
* 14 Oct 2010 - v0.12 - preview now works in wysiwyg mode.
* 14 Oct 2010 - v0.13 - preview now works for google chrome and IE
* 14 Oct 2010 - v0.14 - removed P. from html to textile, replaced with just a return (\n)
* 2011 - minor enhancements
* 2012 - updated for redmine 2.0
* 2013 - Added Tests for Textile to html conversions and html to Textile.

