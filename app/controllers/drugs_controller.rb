# app/controllers/drugs_controller.rb
require 'nokogiri'
require 'open-uri'

class DrugsController < ApplicationController
  def best_selling
    @data = scrape_largest_selling_pharmaceuticals
  end

  private

  def scrape_largest_selling_pharmaceuticals
    url = 'https://en.wikipedia.org/wiki/List_of_largest_selling_pharmaceutical_products#Largest_selling_pharmaceutical_products_of_2015'
    doc = Nokogiri::HTML(URI.open(url))

    # Find the table containing the desired data
    table = doc.css('table.wikitable')[1] # Use the second table on the page

    # Find and process the data you need
    rows = table.css('tr')

    data = []
    rows.each do |row|
      columns = row.css('td')

      next if columns.empty? # Skip header row

      rank = columns[0].text.strip
      brand_name = columns[1].text.strip
      generic_name = columns[2].text.strip
      sales_q1_2014 = columns[3].text.strip
      change_from_q4_2013 = columns[4].text.strip
      companies = columns[5].text.strip
      disease_medical_use = columns[6]&.text&.strip # Use safe navigation to handle nil value
      first_approval_date = columns[7]&.text&.strip # Use safe navigation to handle nil value
      patent_expiration_date = columns[8]&.text&.strip # Use safe navigation to handle nil value

      # Add the extracted data to the data array
      data << {
        rank: rank,
        brand_name: brand_name,
        generic_name: generic_name,
        sales_q1_2014: sales_q1_2014,
        change_from_q4_2013: change_from_q4_2013,
        companies: companies,
        disease_medical_use: disease_medical_use,
        first_approval_date: first_approval_date,
        patent_expiration_date: patent_expiration_date
      }
    end

    data # Return the scraped data
  end
end
