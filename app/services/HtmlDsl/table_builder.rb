module HtmlDsl
  class TableBuilder
    def initialize
      @rows = []
      @header = nil
      @table_attributes = {}
      @header_attributes = {}
      @data_attributes = {}
    end

    def rows(&block)
      row = RowBuilder.new
      row.instance_eval(&block)
      data_attributes_str = attributes_to_html_string(@data_attributes)
      @rows << "<tr#{data_attributes_str}>#{row.cells.join}</tr>"
    end

    def header(&block)
      row = RowBuilder.new
      row.instance_eval(&block)
      @header = row.cells.join
    end

    def table_attributes(attributes)
      @table_attributes = attributes
    end

    def header_attributes(attributes)
      @header_attributes = attributes
    end

    def data_attributes(attributes)
      @data_attributes = attributes
    end

    def build
      table_content = @rows.join(" ")
      table_attributes_str = attributes_to_html_string(@table_attributes)
      "<table#{table_attributes_str}>
        #{thead}
        <tbody>#{table_content}
        </tbody>
      </table>"
    end

    private

    def attributes_to_html_string(attributes)
      attributes.map { |k, v| " #{k}='#{v}'" }.join
    end

    def thead
      return unless @header
      header_attributes_str = attributes_to_html_string(@header_attributes)
      "<thead>
        <tr#{header_attributes_str}>#{@header}</tr>
      </thead>"
    end
  end
end
