document.addEventListener('DOMContentLoaded', function () {
  // this is the only way to successfully retrieve the pubkey without getting a console error that the pubkey is not a 'modern' Stripe key
  const stripeKey = document.getElementById('stripe-key').dataset.publishableKey;
  const stripe = Stripe(stripeKey);

  fetch('/checkouts', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
  })
  .then(response => {
    if (!response.ok) {
      // Handle HTTP errors (e.g., 404, 500)
      console.error('HTTP error:', response.status);
      return response.text().then(text => { 
        // Get the text of the error page.
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
});