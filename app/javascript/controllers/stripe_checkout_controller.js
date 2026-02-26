import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element"]
  static values = { key: String }

  connect() {
    const stripe = Stripe(this.keyValue);

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
      this.checkout = checkout;
      this.checkout.mount(this.elementTarget);
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }

  disconnect() {
    if (this.checkout) {
      this.checkout.unmount();
    }
  }
}