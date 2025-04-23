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
    .then(response => {
      if (!response.ok) {
        // Handle HTTP errors (e.g., 404, 500)
        console.error('HTTP error:', response.status);
        return response.text().then(text => { //Get the text of the error page.
          console.error('Error details:', text);
          throw new Error(`HTTP error! status: ${response.status}`);
        });
      }
      // Check the content type
      const contentType = response.headers.get('content-type');
      if (!contentType || !contentType.includes('application/json')) {
        // Handle non-JSON responses
        console.error('Not a JSON response');
        return response.text().then(text => { //Get the text of the error page.
          console.error('Response details:', text);
          throw new Error('Not a JSON response!');
        });
      }
      //If everything is ok, parse to JSON
      return response.json();
    })
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