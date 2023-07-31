# app/models/tax_rate.rb
class TaxRate < ApplicationRecord
  belongs_to :province

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "gst_rate", "hst_rate", "id", "province_id", "pst_rate", "updated_at"]
  end
end
