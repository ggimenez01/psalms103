# app/helpers/tax_calculator.rb
class TaxCalculator
  def self.calculate_tax_amount(price, tax_type)
    case tax_type
    when 'gst'
      calculate_gst(price)
    when 'pst'
      calculate_pst(price)
    when 'hst'
      calculate_hst(price)
    else
      0
    end
  end

  def self.calculate_gst(price)
    # Implement GST calculation logic here
    gst_rate = 0.05 # Example GST rate of 5%

    # Check if the price is not nil before performing the calculation
    return 0 if price.nil?

    (price * gst_rate).round(2)
  end

  def self.calculate_pst(price)
    # Implement PST calculation logic here
    pst_rate = 0.08 # Example PST rate of 8%

    # Check if the price is not nil before performing the calculation
    return 0 if price.nil?

    (price * pst_rate).round(2)
  end

  def self.calculate_hst(price)
    # Implement HST calculation logic here
    hst_rate = 0.13 # Example HST rate of 13%

    # Check if the price is not nil before performing the calculation
    return 0 if price.nil?

    (price * hst_rate).round(2)
  end
end
