// Script is at the bottom of the view, so DOM elements are already available.
// No DOMContentLoaded wrapper needed - and it would break Turbo navigation.
const stripeKey = document.getElementById('stripe-key').dataset.publishableKey;
const stripe = Stripe(stripeKey);

fetch('/checkout_sessions', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
  },
})
.then(response => {
  if (!response.ok) {
    console.error('HTTP error:', response.status);
    return response.text().then(text => {
      console.error('Error details:', text);
      if (response.status === 500 ) {
        console.error('Server encountered an internal error.');
        alert('An unexpected server error occurred. Please try again later.');
      } else {
        throw new Error(`HTTP error! status: ${response.status}`);
      };
    });
  }
  return response.json();
})
.then((data) => {
  return stripe.initEmbeddedCheckout({
    clientSecret: data.clientSecret
  });
})
.then((checkout) => {
  checkout.mount('#checkout-element');
})
.catch(error => {
  console.error('Error:', error);
});