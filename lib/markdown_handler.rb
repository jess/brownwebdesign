# config/initializers/redcarpet.rb
 
#class ActionView::Template
#  class Redcarpet < Handler
#    include Handlers::Compilable
# 
#    def compile template
#      ::Redcarpet.new(template.source).to_html.inspect
#    end
#  end
# 
#  register_template_handler :markdown, Redcarpet
#end
#
#require 'redcarpet'
#
module MarkdownHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template)
    compiled_source = erb.call(template)
    "Postmarkdown::MarkdownRenderer.new.render(begin;#{compiled_source};end).html_safe"
  end
end

ActionView::Template.register_template_handler :md, MarkdownHandler
