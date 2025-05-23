document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('payment-form');
  const stripePublishableKey = form.dataset.stripePublishableKey;
  const checkoutSuccessPath = form.dataset.checkoutSuccessPath;

  const stripe = Stripe(stripePublishableKey);
  console.log(checkoutSuccessPath);
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
          //Get the text of the error page.
          console.error('Error details:', text);
          if (response.status === 500 ) {
            console.error('Server encountered an internal error.');
            alert('An unexpected server error occured. Please try again later.');
          } else {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
        });
      }
      // Check the content type
      const contentType = response.headers.get('content-type');
      if (!contentType || !contentType.includes('application/json')) {
        // Handle non-JSON responses
        console.error('Not a JSON response');
        return response.text().then(text => { 
          //Get the text of the error page.
          console.error('Response details:', text);
          throw new Error('Not a JSON response!');
        });
      }
      //If everything is ok, parse to JSON
      return response.json();
    })
    .then((data) => {
      const clientSecret = data.clientSecret;
      const optionsShipping = { mode: 'shipping' };
      const optionsBilling = { mode: 'billing' };
      const elements = stripe.elements( { clientSecret: clientSecret});      
      const shippingAddressElement = elements.create('address', optionsShipping);
      const billingAddressElement = elements.create('address', optionsBilling);
      const paymentElement = elements.create('payment');
      shippingAddressElement.mount('#address-element-shipping');
      billingAddressElement.mount('#address-element-billing');
      paymentElement.mount('#payment-element');
      form.addEventListener('submit', function (event) {
        event.preventDefault();
    
        stripe.confirmPayment({
          elements,
          confirmParams: {
            return_url: checkoutSuccessPath,
          },
        }).then(function (result) {
          if (result.error) {
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
          alert('There was an error processing your payment. Please try again.');
          console.error('Unexpected error:', error)
        });
      });
    })  
});