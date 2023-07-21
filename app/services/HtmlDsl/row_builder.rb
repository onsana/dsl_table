module HtmlDsl
  class RowBuilder
    def initialize
      @cells = []
    end

    def cell(content, attributes = {})
      cell_attributes_str = attributes_to_html_string(attributes)
      @cells << "<td#{cell_attributes_str}>#{content}</td>"
    end

    attr_reader :cells

    private

    def attributes_to_html_string(attributes)
      attributes.map { |k, v| " #{k}='#{v}'" }.join
    end
  end
end
