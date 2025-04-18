document.addEventListener('DOMContentLoaded', function () {
  
  const form = document.getElementById('payment-form');
  const stripePublishableKey = form.dataset.stripePublishableKey;

  const stripe = Stripe(stripePublishableKey);

  fetch('/create_checkout', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
  })
    .then((response) => response.json())
    .then((data) => {
      const clientSecret = data.clientSecret;
      
      const elements = stripe.elements( { clientSecret: clientSecret});
      const paymentElement = elements.create('payment');
      paymentElement.mount('#payment-element');
      
      form.addEventListener('submit', function (event) {
        event.preventDefault();
    
        stripe.confirmPayment({
          elements,
          confirmParams: {
            return_url: 'http://localhost:3000/payment_success',
          },
        }).then(function (result) {
          if (result.error) {
            // Handle error
            console.error(result.error.message);
            alert(result.error.message);
          } else {
            // Handle successful payment
            console.log('Payment successful!');
            alert('Payment successful!');
          }
        });
      });
    })
    .catch((error) => {
      console.error('Error fetching client secret:', error)
      alert(error.message);
    });
});