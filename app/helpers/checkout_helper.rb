module CheckoutHelper
  def provinces_options
    @provinces_options ||= {
      'Alberta' => { pst: 0.00, gst: 0.05, hst: 0.00 },
      'British Columbia' => { pst: 0.07, gst: 0.05, hst: 0.00 },
      'Manitoba' => { pst: 0.07, gst: 0.05, hst: 0.00 },
      'New Brunswick' => { pst: 0.00, gst: 0.00, hst: 0.15 },
      'Newfoundland and Labrador' => { pst: 0.00, gst: 0.00, hst: 0.15 },
      'Northwest Territories' => { pst: 0.00, gst: 0.05, hst: 0.00 },
      'Nova Scotia' => { pst: 0.00, gst: 0.00, hst: 0.15 },
      'Nunavut' => { pst: 0.00, gst: 0.05, hst: 0.00 },
      'Ontario' => { pst: 0.00, gst: 0.00, hst: 0.13 },
      'Prince Edward Island' => { pst: 0.00, gst: 0.00, hst: 0.15 },
      'Quebec' => { pst: 0.10, gst: 0.05, hst: 0.00 },
      'Saskatchewan' => { pst: 0.06, gst: 0.05, hst: 0.00 },
      'Yukon' => { pst: 0.00, gst: 0.05, hst: 0.00 }
    }
  end
    
end
