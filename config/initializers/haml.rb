# This make the haml markdown filter protected against javascript injection
# attacks.
module KanbanRoots
  module Filters
    module Markdown
      include Haml::Filters::Base
      lazy_require 'rdiscount'

      def render(text)
        ::RDiscount.new(text, :filter_html).to_html
      end
    end
  end
end

