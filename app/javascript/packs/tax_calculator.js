// app/assets/javascripts/tax_calculator.js

// Function to calculate tax amount based on tax type and province
function calculateTaxAmount(totalPrice, taxType, province) {
  const taxRates = {
    'gst': 0.05,
    'pst': 0.07,
    'hst': 0.15,
    // Add other tax types and their corresponding tax rates here.
    'Alberta': 0.05,
    'British Columbia': 0.12,
    'Manitoba': 0.13,
    'New Brunswick': 0.15,
    'Newfoundland and Labrador': 0.15,
    'Northwest Territories': 0.05,
    'Nova Scotia': 0.15,
    'Nunavut': 0.05,
    'Ontario': 0.13,
    'Prince Edward Island': 0.15,
    'Quebec': 0.15,
    'Saskatchewan': 0.11,
    'Yukon': 0.05,
    // Add other provinces and their corresponding tax rates here.
  };

  const taxRate = taxRates[taxType] || taxRates[province] || 0.0;
  const taxAmount = totalPrice * taxRate;

  return formatCurrency(taxAmount);
}

// Function to format currency display
function formatCurrency(amount) {
  return '$' + amount.toFixed(2);
}
