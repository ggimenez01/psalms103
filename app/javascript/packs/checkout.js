// app/assets/javascripts/checkout.js
document.addEventListener('turbolinks:load', () => { 

  // Function to format currency display
  function formatCurrency(amount) {
    return '$' + amount.toFixed(2);
  }

  // Function to calculate total price based on the tax rate
  function calculateTotalCartPrice(provinceTax) {
    const subtotal = parseFloat(document.getElementById('subtotal').innerText);
    const taxAmount = subtotal * provinceTax;
    const totalCartPrice = subtotal + taxAmount;

    return totalCartPrice;
  }

  // Event listener for province selection change
  const provinceSelect = document.getElementById('province-select');
  provinceSelect.addEventListener('change', () => {
    updateTaxAndTotalPrice();
  });

  // Call the update function initially to set the initial tax and total price
  updateTaxAndTotalPrice();
});
