class MainController < ApplicationController
  def index
    @html_table = HtmlDsl::HtmlBuilder.table do
      table_attributes class: "table", width: "500px", border: "1", cellpadding: "10"
      header_attributes class: "header-row"
      data_attributes class: "data-row"

      header do
        cell("Name", class: "header-cell")
        cell("Age", class: "header-cell")
        cell("Occupation", class: "header-cell")
      end
      5.times do |n|
        rows do
          cell("Jane Smith-#{n}", class: "data-cell")
          cell("#{28 + n}", class: "data-cell")
          cell("Designer", class: "data-cell")
        end
      end
    end

    @simple_html_table = HtmlDsl::HtmlBuilder.table do
      header do
        cell("Name")
        cell("Age")
        cell("Occupation")
      end

      rows do
        cell("John Doe")
        cell("35")
        cell("Engineer")
      end

      rows do
        cell("Jane Smith")
        cell("31")
        cell("Designer")
      end
    end

    @simple_wo_header_table = HtmlDsl::HtmlBuilder.table do
      rows do
        cell("John Doe")
        cell("30")
        cell("Engineer")
      end

      rows do
        cell("Jane Smith")
        cell("34")
        cell("Designer")
      end
    end
  end
end
