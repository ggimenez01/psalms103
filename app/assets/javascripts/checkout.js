document.addEventListener('DOMContentLoaded', () => {
  function updateValues() {
    console.log('Updating values...');
    const selectedProvince = document.getElementById('province-select').value;
    console.log('Selected province:', selectedProvince);
    
    // Function to calculate tax amount based on tax type and province
    function calculateTaxAmount(totalPrice, taxType, province) {
      const taxRates = {
        'Alberta': { 'pst': 0, 'gst': 5, 'hst': 0 },
  'British Columbia': { 'pst': 7, 'gst': 5, 'hst': 0 },
  'Manitoba': { 'pst': 7, 'gst': 5, 'hst': 0 },
  'New Brunswick': { 'pst': 0, 'gst': 0, 'hst': 15 },
  'Newfoundland and Labrador': { 'pst': 0, 'gst': 0, 'hst': 15 },
  'Northwest Territories': { 'pst': 0, 'gst': 5, 'hst': 0 },
  'Nova Scotia': { 'pst': 0, 'gst': 0, 'hst': 15 },
  'Nunavut': { 'pst': 0, 'gst': 5, 'hst': 0 },
  'Ontario': { 'pst': 0, 'gst': 0, 'hst': 13 },
  'Prince Edward Island': { 'pst': 0, 'gst': 0, 'hst': 15 },
  'Quebec': { 'pst': 9.98, 'gst': 5, 'hst': 0 },
  'Saskatchewan': { 'pst': 6, 'gst': 5, 'hst': 0 },
  'Yukon': { 'pst': 0, 'gst': 5, 'hst': 0 },
      };

      const taxRate = taxRates[taxType] || taxRates[province] || 0.0;
      const taxAmount = totalPrice * taxRate;

      return taxAmount;
    }

    // Function to format currency display
    function formatCurrency(amount) {
      return '$' + amount.toFixed(2);
    }

    const subtotal = parseFloat(document.getElementById('subtotal').innerText);
    const gstAmount = calculateTaxAmount(subtotal, 'gst', selectedProvince);
    const pstAmount = calculateTaxAmount(subtotal, 'pst', selectedProvince);
    const hstAmount = calculateTaxAmount(subtotal, 'hst', selectedProvince);
    const grandTotal = subtotal + gstAmount + pstAmount + hstAmount;

    console.log('GST amount:', gstAmount);
    console.log('PST amount:', pstAmount);
    console.log('HST amount:', hstAmount);
    console.log('Grand total:', grandTotal);

    document.getElementById('gst-amount-cell').innerText = formatCurrency(gstAmount);
    document.getElementById('pst-amount-cell').innerText = formatCurrency(pstAmount);
    document.getElementById('hst-amount-cell').innerText = formatCurrency(hstAmount);
    document.getElementById('grand-total-cell').innerText = formatCurrency(grandTotal);
  }

  document.getElementById('province-select').addEventListener('change', updateValues);
  updateValues(); // Call the function initially to populate values on page load
});
