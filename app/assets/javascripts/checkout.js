document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('payment-form');
  const stripePublishableKey = form.dataset.stripePublishableKey;
  const checkoutSuccessPath = form.dataset.checkoutSuccessPath;

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

        const submitButton = form.querySelector('button[type="submit"]');
        submitButton.disabled = true;
    
        stripe.confirmPayment({
          elements,
          confirmParams: {
            return_url: checkoutSuccessPath,
          },
        }).then(function (result) {
          if (result.error) {
            submitButton.disabled = false; // allows user to retry form submission if an error has occured

            if (result.error.type === 'card_error' || result.error.type === 'validation_error') {
              alert("There was an error processing your card. Please try another payment method.")
            }
            console.error(result.error.message);
          } else {
            // Handle successful payment
            console.log('Payment successful!');
            alert('Payment successful!');
          }
        }).catch((error) => {
          submitButton.disabled = false;
          
          alert('There was an error processing your payment. Please try again.');
          console.error('Unexpected error:', error)
        });
      });
    })  
});