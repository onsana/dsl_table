require "rails_helper"

RSpec.describe HtmlDsl::HtmlBuilder do
  describe "basic usage w/o header and classes" do
    let(:html_table) {
      HtmlDsl::HtmlBuilder.table do
        rows do
          cell("Jane Smith")
          cell("34")
          cell("Developer")
        end
      end
    }

    it "should render simple table" do
      expect(html_table).to include("<table>")
      expect(html_table.scan(/<tr>/).count).to eq(1)
      expect(html_table.scan(/<td>/).count).to eq(3)
      expect(html_table).to include("<td>Jane Smith</td>")
      expect(html_table).to include("<td>34</td>")
      expect(html_table).to include("<td>Developer</td>")
    end
  end

  describe "basic usage w/o attributes" do
    let(:html_table) {
      HtmlDsl::HtmlBuilder.table do
        header do
          cell("Name")
          cell("Age")
          cell("Occupation")
        end
        rows do
          cell("Martim Moniz")
          cell("24")
          cell("Designer")
        end
      end
    }

    it "should render simple table" do
      expect(html_table).to include("<table>")
      expect(html_table).to include("<thead>")
      expect(html_table.scan(/<tr>/).count).to eq(2)
      expect(html_table.scan(/<td>/).count).to eq(6)
      expect(html_table).to include("<td>Martim Moniz</td>")
      expect(html_table).to include("<td>24</td>")
      expect(html_table).to include("<td>Designer</td>")
    end
  end

  describe "advanced usage with attributes" do
    let(:html_table) {
      HtmlDsl::HtmlBuilder.table do
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
            cell("Engineer", class: "data-cell")
          end
        end
      end
    }

    it "creates an HTML table with specified attributes" do
      expect(html_table).to include("<table")
      expect(html_table).to include("<thead>")
      expect(html_table).to include("class='table'")
      expect(html_table).to include("width='500px'")
      expect(html_table).to include("border='1'")
      expect(html_table).to include("cellpadding='10'")
    end

    it "creates the correct number of rows and cells" do
      expect(html_table.scan(/<tr class='header-row'>/).count).to eq(1)
      expect(html_table.scan(/<td class='header-cell'>/).count).to eq(3)
      expect(html_table.scan(/<tr class='data-row'>/).count).to eq(5)
      expect(html_table.scan(/<td class='data-cell'>/).count).to eq(15)
    end

    it "applies the correct attributes and classes to rows and cells" do
      expect(html_table).to include("<tr class='header-row'>")
      expect(html_table).to include("<tr class='data-row'>")
      expect(html_table).to include("<td class='header-cell'>Name</td>")
      expect(html_table).to include("<td class='data-cell'>Jane Smith-1</td>")
    end
  end
end
