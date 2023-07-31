<<<<<<< HEAD
//= require jquery
//= require jquery_ujs
=======
//= require ckeditor/ckeditor
// app/assets/javascripts/application.js
//= require tax_calculator
//= require checkout
document.addEventListener('DOMContentLoaded', () => {
    const quantityInputs = document.querySelectorAll('.cart-quantity-input');
    
    quantityInputs.forEach(input => {
      const updateTotal = () => {
        const cartItemRow = input.closest('.cart-item-row');
        const priceElement = cartItemRow.querySelector('.cart-item-price');
        const quantity = parseInt(input.value);
        const price = parseFloat(priceElement.dataset.price);
        const total = (quantity * price).toFixed(2);
        cartItemRow.querySelector('.cart-item-total').innerText = total;
      };
      
      input.addEventListener('change', updateTotal);
      input.addEventListener('input', updateTotal);
    });
  });
  
>>>>>>> 3b64b9dd9150b006b7b2651e2644892e4e29d7c3
