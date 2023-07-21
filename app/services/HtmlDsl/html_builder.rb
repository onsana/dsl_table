module HtmlDsl
  class HtmlBuilder
    def self.table(&block)
      table_builder = HtmlDsl::TableBuilder.new
      table_builder.instance_eval(&block)
      table_builder.build
    end
  end
end
