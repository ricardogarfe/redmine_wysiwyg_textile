#
# Redmine Wysiwyg Textile Editor
#
# P.J.Lawrence October 2010
#
module RedmineWysiwygTextile
  module Helper
    unloadable
    
    def wikitoolbar_for(field_id)
      if (field_id!='notes')
        # only for wiki pages for now
        wikitoolbar_for_wysiwyg(field_id)
      else
        wikitoolbar_for_non_wysiwyg(field_id)
      end
    end
    
    def wikitoolbar_for_non_wysiwyg(field_id)
          heads_for_wiki_formatter
          # Is there a simple way to link to a public resource?
          url = "#{Redmine::Utils.relative_url_root}/help/wiki_syntax.html"
          
          help_link = link_to(l(:setting_text_formatting), url,
            :onclick => "window.open(\"#{ url }\", \"\", \"resizable=yes, location=no, width=300, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")
      
          javascript_tag("var wikiToolbar = new jsToolBar($('#{field_id}')); wikiToolbar.setHelpLink('#{escape_javascript help_link}'); wikiToolbar.draw();")
    end
    
    def wikitoolbar_for_wysiwyg(field_id)
      heads_for_wiki_formatter
       file = "#{Redmine::Utils.relative_url_root}/help/wiki_syntax.html"
       help_link = link_to(l(:setting_text_formatting), file,
            :onclick => "window.open(\"#{ file }\", \"\", \"resizable=yes, location=no, width=300, height=640, menubar=no, status=no, scrollbars=yes\"); return false;")
      
        javascript_include_tag('/tinymce/jscripts/tiny_mce/tiny_mce.js', :plugin => 'redmine_wysiwyg_textile') +
        javascript_tag("
            var tinyenabled=false;
            function setuptinymce() {
             tinyMCE.init({
               mode : 'exact',
               elements : '#{field_id}',
               formats : {strikethrough : {inline : 'del'}, 
                          underline : {inline : 'ins'} },
               theme : 'advanced',
               skin : 'o2k7',
               skin_variant: 'silver',
               plugins : 'table,print',
               theme_advanced_buttons1: 'bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,|,formatselect,|,bullist,numlist,|,indent,outdent,|,link,unlink,code,print,|,tablecontrols',
               theme_advanced_buttons2: '',
               theme_advanced_buttons3: '',
               table_styles : 'Header 1=header1;Header 2=header2;Header 3=header3',
               table_cell_styles : 'Header 1=header1;Header 2=header2;Header 3=header3;Table Cell=tableCel1',
               table_row_styles : 'Header 1=header1;Header 2=header2;Header 3=header3;Table Row=tableRow1',
               table_cell_limit : 100,
               table_row_limit : 5,
               table_col_limit : 5,
               width : '100%',
               height: '240px',
               theme_advanced_toolbar_location : 'top',
               theme_advanced_toolbar_align : 'left',
               theme_advanced_resizing : true,
               theme_advanced_statusbar_location : 'bottom',
               theme_advanced_path : false,
               theme_advanced_resizing : true,
               theme_advanced_resize_horizontal : false,
               theme_advanced_resizing_use_cookie : false
              });
            }
            function toggleEditor(id,DisplayTiny) {
              var ana = $('#{field_id}');
                if (DisplayTiny==1 && tinyenabled==false) {
                  new Ajax.Request('#{Redmine::Utils.relative_url_root}/convert/wysiwygtotextiletohtml', {asynchronous:false, evalScripts:false, method:'post', onSuccess:function(request){UpdateFile(request)}, parameters:{convert_content: $('#{field_id}').value}});
                  setuptinymce();
                  tinyenabled=true;
                  the_jstoolbar.toolbar.style.display = 'none';
                  if (PreviewElem != null) {
                    PreviewElem.onclick=function(){ UpdatePreviewHtml(); }
                  }
                  return;
                }
                if (!tinyMCE.get(id)) {
                  if (DisplayTiny==1) {
                     new Ajax.Request('#{Redmine::Utils.relative_url_root}/convert/wysiwygtotextiletohtml', {asynchronous:false, evalScripts:false, method:'post', onSuccess:function(request){UpdateFile(request)}, parameters:{convert_content: $('#{field_id}').value}});
                     the_jstoolbar.toolbar.style.display = 'none';
                     tinyMCE.execCommand('mceAddControl', false, id);
                     if (PreviewElem != null) {
                      PreviewElem.onclick=function(){ UpdatePreviewHtml(); }
                     }
                  }
                }
                else {
                   if (DisplayTiny==0) {
                     tinyMCE.execCommand('mceRemoveControl', false, id);
                     new Ajax.Request('#{Redmine::Utils.relative_url_root}/convert/wysiwygtohtmltotextile', {asynchronous:false, evalScripts:false, method:'post', onSuccess:function(request){UpdateFile(request)}, parameters:{convert_content: $('#{field_id}').value}});
                     the_jstoolbar.toolbar.style.display = 'block';
                     if (PreviewElem != null) {
                      PreviewElem.onclick=function(){ eval(TheTextilePreviewFunction) }
                     }
                   }
                }
            }
            function UpdateFile(TheText) {
               var text1 = document.getElementById('#{field_id}');
               text1.value = TheText.responseText;
               if (tinyenabled==true) {
                  tinyMCE.get('#{field_id}').setContent(TheText.responseText);
               }
               return true;
            }
        ") + 
        javascript_tag("
        function Tinymcesubmit(id) {              
               if (tinyMCE.get(id)) {
                  tinyMCE.execCommand('mceRemoveControl', false, id);
                  new Ajax.Request('#{Redmine::Utils.relative_url_root}/convert/wysiwygtohtmltotextile', {asynchronous:false, evalScripts:false, method:'post', onSuccess:function(request){UpdateFile(request)}, parameters:{convert_content: $('#{field_id}').value}});
                  the_jstoolbar.toolbar.style.display = 'block';
               }
            } 
            function AddWikiformSubmit(textarea) {
               var aTextArea=document.getElementById(textarea);
               if (aTextArea) {
                 aform=aTextArea.form;
                 if (aform) {
                   aform.onsubmit=function(){return Tinymcesubmit(textarea);};
                 }
               }
             }
             
             function SetDefaultEditor(textarea) {
               toggleEditor(textarea,#{User.current.preference.default_editor && User.current.preference.default_editor == 'wysiwyg' ? 1 : 0});
             }
             
          ") +
          javascript_tag("
          var ThePreviewFunction=null;
          var TheTextilePreviewFunction=null;
          var PreviewElem=null;
          function UpdatePreviewTextile(TheText) {
               var text2 = document.getElementById('#{:preview}');
               text2.innerHTML = TheText.responseText;
               var text3=TheText.responseText;
               text3 ='content%5Btext%5D='+escape(text3);
               eval(ThePreviewFunction);
               return (false);
          }
          function UpdatePreviewHtml() {
               var TheText;
               if (tinyenabled==true) {
                  TheText = tinyMCE.get('#{field_id}').getContent();
                  TheText ='content%5Btext%5D='+escape(TheText);
                  new Ajax.Request('#{Redmine::Utils.relative_url_root}/convert/wysiwygtohtmltotextile', {asynchronous:false, evalScripts:false, method:'post', onSuccess:function(request){UpdatePreviewTextile(request)}, parameters:TheText});
               }
               return (false);
          }
          function GetPreviewFunction(textarea) {
                
                var elemlist = document.getElementsByName(\"commit\");
                if (elemlist == null) return;
                var elem=elemlist[0]
                do {
                  elem = elem.nextSibling;
                  if (elem) {
                      if (elem.nodeName.toLowerCase() == \"a\") {
                          if (elem.onclick.toString().match(/Ajax.Updater.+preview/)){ 
                              PreviewElem=elem;
                              TheTextilePreviewFunction=PreviewElem.onclick.toString();
                              
                              TheTextilePreviewFunction=TheTextilePreviewFunction.replace(\"function onclick(event)\", \"\");
                              TheTextilePreviewFunction=TheTextilePreviewFunction.replace(\"function anonymous()\", \"\");
                              TheTextilePreviewFunction=TheTextilePreviewFunction.replace(\"return false;\", \"\");
                              ThePreviewFunction= TheTextilePreviewFunction.replace(\"Form.serialize(\\\"wiki_form\\\")\", \"text3\");
                              ThePreviewFunction= ThePreviewFunction.replace(\"Form.serialize(\\'wiki_form\\')\", 'text3');
                              break;
                           }
                       }
                   }
                } while (elem);
           }
          ") +
         "
            <Input type = radio Name = \"textilewysiwyg\" #{User.current.preference.default_editor && User.current.preference.default_editor == 'wysiwyg' ? '' : 'CHECKED'} onClick=\"javascript:toggleEditor('#{field_id}',0)\">textile
            <Input type = radio Name = \"textilewysiwyg\" #{User.current.preference.default_editor && User.current.preference.default_editor == 'wysiwyg' ? 'CHECKED' : ''} onClick=\"javascript:toggleEditor('#{field_id}',1)\">wysiwyg
            
            <div id='workarea' class='wiki'></div>".html_safe +
            javascript_tag("var the_jstoolbar = new jsToolBar($('#{field_id}'));
                    the_jstoolbar.setHelpLink('#{help_link}');
                    the_jstoolbar.draw();
                    AddWikiformSubmit('#{field_id}');
                    //GetPreviewFunction('#{field_id}');
                    SetDefaultEditor('#{field_id}');
           ")
    end
    
    def initial_page_content(page)
       "h1. #{ERB::Util.html_escape page.pretty_title}"
    end
   
    def heads_for_wiki_formatter
      unless @heads_for_wiki_formatter_included
        content_for :header_tags do
          javascript_include_tag('jstoolbar/jstoolbar') +
          javascript_include_tag('jstoolbar/textile') +
          javascript_include_tag("jstoolbar/lang/jstoolbar-#{current_language.to_s.downcase}") +
          stylesheet_link_tag('jstoolbar')
        end
        @heads_for_wiki_formatter_included = true
      end
    end
   
  end
end
