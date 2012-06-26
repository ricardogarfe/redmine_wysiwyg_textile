require 'html2textile'
require 'sgml-parser'
require 'redcloth3'
require 'digest/md5'

# P.J.Lawrence October 2010
# Stefan Langenmaier 2012

class HTMLFormatter< RedCloth3
        include ActionView::Helpers::TagHelper
        
        RULES = [:textile, :block_markdown_rule]
        
        def initialize(*args)
          super
          self.hard_breaks=true
          self.no_span_caps=true
          self.filter_styles=true
        end
        
        def to_html(*rules)
          super(*RULES).to_s
        end

        def get_section(index)
          section = extract_sections(index)[1]
          hash = Digest::MD5.hexdigest(section)
          return section, hash
        end

        def update_section(index, update, hash=nil)
          t = extract_sections(index)
          if hash.present? && hash != Digest::MD5.hexdigest(t[1])
            raise Redmine::WikiFormatting::StaleSectionError
          end
          t[1] = update unless t[1].blank?
          t.reject(&:blank?).join "\n\n"
        end

        def extract_sections(index)
          @pre_list = []
          text = self.dup
          rip_offtags text, false, false
          before = ''
          s = ''
          after = ''
          i = 0
          l = 1
          started = false
          ended = false
          text.scan(/(((?:.*?)(\A|\r?\n\r?\n))(h(\d+)(#{A}#{C})\.(?::(\S+))? (.*?)$)|.*)/m).each do |all, content, lf, heading, level|
            if heading.nil?
              if ended
                after << all
              elsif started
                s << all
              else
                before << all
              end
              break
            end
            i += 1
            if ended
              after << all
            elsif i == index
              l = level.to_i
              before << content
              s << heading
              started = true
            elsif i > index
              s << content
              if level.to_i > l
                s << heading
              else
                after << heading
                ended = true
              end
            else
              before << all
            end
          end
          sections = [before.strip, s.strip, after.strip]
          sections.each {|section| smooth_offtags_without_code_highlighting section}
          sections
        end

  
      private
  
        # Patch for RedCloth.  Fixed in RedCloth r128 but _why hasn't released it yet.
        # <a href="http://code.whytheluckystiff.net/redcloth/changeset/128">http://code.whytheluckystiff.net/redcloth/changeset/128</a>
        def hard_break( text ) 
          text.gsub!( /(.)\n(?!\n|\Z|>| *([#*=]+(\s|$)|[{|]))/, "\\1<br />" ) if hard_breaks
        end
        
        alias :smooth_offtags_without_code_highlighting :smooth_offtags
        # Patch to add code highlighting support to RedCloth
        def smooth_offtags( text )
          unless @pre_list.empty?
            ## replace <pre> content
            text.gsub!(/<redpre#(\d+)>/) do
              content = @pre_list[$1.to_i]
              if content.match(/<code\s+class="(\w+)">\s?(.+)/m)
                content = "<code class=\"#{$1} syntaxhl\">" +
                  Redmine::SyntaxHighlighting.highlight_by_language($2, $1)
              end
              content
            end
          end
        end
        
        AUTO_LINK_RE = %r{
                        (                          # leading text
                          <\w+.*?>|                # leading HTML tag, or
                          [^=<>!:'"/]|             # leading punctuation, or 
                          ^                        # beginning of line
                        )
                        (
                          (?:https?://)|           # protocol spec, or
                          (?:s?ftps?://)|
                          (?:www\.)                # www.*
                        )
                        (
                          (\S+?)                   # url
                          (\/)?                    # slash
                        )
                        ([^\w\=\/;\(\)]*?)               # post
                        (?=<|\s|$)
                       }x unless const_defined?(:AUTO_LINK_RE)
                       
              # Turns all urls into clickable links (code from Rails).
        def inline_auto_link(text)
          text.gsub!(AUTO_LINK_RE) do
            all, leading, proto, url, post = $&, $1, $2, $3, $6
            if leading =~ /<a\s/i || leading =~ /![<>=]?/
              # don't replace URL's that are already linked
              # and URL's prefixed with ! !> !< != (textile images)
              all
            else
              # Idea below : an URL with unbalanced parethesis and
              # ending by ')' is put into external parenthesis
              if ( url[-1]==?) and ((url.count("(") - url.count(")")) < 0 ) )
                url=url[0..-2] # discard closing parenth from url
                post = ")"+post # add closing parenth to post
              end
              tag = content_tag('a', proto + url, :href => "#{proto=="www."?"http://www.":proto}#{url}", :class => 'external')
              %(#{leading}#{tag}#{post})
            end
          end
        end

        # Turns all email addresses into clickable links (code from Rails).
        def inline_auto_mailto(text)
          text.gsub!(/([\w\.!#\$%\-+.]+@[A-Za-z0-9\-]+(\.[A-Za-z0-9\-]+)+)/) do
            mail = $1
            if text.match(/<a\b[^>]*>(.*)(#{Regexp.escape(mail)})(.*)<\/a>/)
              mail
            else
              content_tag('a', mail, :href => "mailto:#{mail}", :class => "email")
            end
          end
        end                 
  
    end

class ConvertController < ApplicationController
  unloadable
      
  def wysiwygtohtmltotextile
    #@text=params[:content][:text]
    @text = params[:convert_content] 
    # name="content[text]" --- wiki page
    # name="issue[description]" -- issue
    # name="notes" -- note
    # name="settings[mail_handler_body_delimiters]" - settings
    # name="project[description]"
    # name="message[content]" -- forum
    htmlparser = HTMLToTextileParser.new
    htmlparser.feed(@text)
    @text=htmlparser.to_textile
    render :partial => 'convert'
  end
  
  def wysiwygtotextiletohtml
    #@text=params[:content][:text]
    @text = params[:convert_content] 
    #@text=RedCloth3.new(params[:content][:text]).to_html
    #@text = @text.gsub(/(\r?\n|\r\n?)/, "\n> ") + "\n\n"
    @text=HTMLFormatter.new(@text).to_html if @text
    render :partial => 'convert'
  end
end
