module Cell
  module Haml::Rails
    def self.included(includer)
      includer.send :include, ActionView::Helpers::FormHelper
      includer.send :include, Helpers
    end

    module Helpers
      # From FormTagHelper. why do they escape every possible string? why?
      def form_tag_in_block(html_options, &block)
        content = capture(&block)
        form_tag_with_body(html_options, content)
      end

      def form_tag_with_body(html_options, content)
        "#{form_tag_html(html_options)}" << content.to_s << "</form>"
      end

      # with Haml 6.x, we don't need magical output buffers since yielding a block returns the
      # content.
      def with_output_buffer(block_buffer=ViewModel::OutputBuffer.new)
        yield
      end

      def capture(*args)
        yield(*args)
      end

      def content_tag(name, content_or_options_with_block=nil, options=nil, escape=false, &block)
        super
      end
    end
  end
end
