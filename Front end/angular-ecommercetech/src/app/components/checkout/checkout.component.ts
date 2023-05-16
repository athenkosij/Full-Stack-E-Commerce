//import { ThisReceiver } from '@angular/compiler';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
//import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
//import { Route, Router } from 
import { Order } from 'src/app/common/order';
import { OrderItem } from 'src/app/common/order-item';
import { PaymentInfo } from 'src/app/common/payment-info';
import { Purchase } from 'src/app/common/purchase';
import { CartService } from 'src/app/services/cart.service';
import { CheckoutService } from 'src/app/services/checkout.service';
import { PeriodFormServiceService } from 'src/app/services/period-form-service.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-checkout',
  templateUrl: './checkout.component.html',
  styleUrls: ['./checkout.component.css']
})
export class CheckoutComponent implements OnInit {

  checkoutFormGroup: FormGroup; // Collection of forms elements, form groups or from elements
  totalQuantity: number = 0;
  totalPrice: number = 0;  

  creditCardYears: number[] = [];
  creditCardMonths: number[] = []; 

  // storage: Storage = sessionStorage;

  // initialize Stripe API
  stripe = Stripe(environment.stripePublishableKey);

  paymentInfo: PaymentInfo = new PaymentInfo();
  cardElement: any;
  displayError: any = "";

  isDisabled: boolean = false;

  constructor(private formBuilder: FormBuilder,
              private periodFormService: PeriodFormServiceService,
              private cartService: CartService,
              private checkoutService: CheckoutService,
              private router: Router) { }

  ngOnInit(): void {

    // setup Stripe payment form
    this.setupStripePaymentForm();

    this.reviewCartTotals();

    this.checkoutFormGroup = this.formBuilder.group({
      customer: this.formBuilder.group({
        firstName: new FormControl('',[Validators.required, Validators.minLength(2)]),
        lastName: new FormControl('',[Validators.required, Validators.minLength(2)]),
        email: new FormControl('', 
                                [Validators.required, Validators.pattern('^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}$')])
      }),
      shippingAddress: this.formBuilder.group({
        street: new FormControl('',[Validators.required, Validators.minLength(2)]),
        city: new FormControl('',[Validators.required, Validators.minLength(2)]),
        province: new FormControl('',[Validators.required]),      
        country: new FormControl('',[Validators.required, Validators.minLength(2)]),
        zipCode: new FormControl('',[Validators.required, Validators.minLength(4)])
      }),
      billingAddress: this.formBuilder.group({
        street: new FormControl('',[Validators.required, Validators.minLength(2)]),
        city: new FormControl('',[Validators.required, Validators.minLength(2)]),
        province: new FormControl('',[Validators.required]),      
        country: new FormControl('',[Validators.required, Validators.minLength(2)]),
        zipCode: new FormControl('',[Validators.required, Validators.minLength(4)])
      }),
      
      creditCard: this.formBuilder.group({
        /*
        cardType: [''],
        nameOnCard: [''],
        cardNumber: [''],
        securityCode: [''],
        expirationMonth: [''],
        expirationYear: [''] */
      }) 
    });

    /*
    // populate credit card months
    const startMonth: number = new Date().getMonth() + 1;
    console.log("startMonth: " + startMonth);

    this.periodFormService.getCreditCardMonths(startMonth).subscribe(
      data => {
        console.log("retrieved credit card months: " + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    )

    // populate credit card years
    this.periodFormService.getCreditCardYears().subscribe(
      data => {
        console.log("Retrieved credit card years: " + JSON.stringify(data));
        this.creditCardYears = data;
      }
    ) */
  } 
  setupStripePaymentForm() {

    // get a handle to stripe elements
    var elements = this.stripe.elements();

    // Create a card element
    this.cardElement = elements.create('card', { hidePostalCode: true});

    // Add an instance of card UI component into the 'card-element' div
    this.cardElement.mount('#card-element');

    // Add event binding for the 'change' event on the card element
    this.cardElement.on('change', (event) => {

      // get a handle to card-errors element
      this.displayError = document.getElementById('card-errors');

      if (event.complete) {
        this.displayError.textContent = "";
      } else if (event.error) {
        // show validation error to customer
        this.displayError.textContent = event.error.message;
      }
    });
  }

  reviewCartTotals() {

    // Subscribe to cartService.totalQuantity
    this.cartService.totalQuantity.subscribe(
      totalQuantity => this.totalQuantity = totalQuantity
    );

    // subscribe to cartService.totalPrice
    this.cartService.totalPrice.subscribe(
      totalPrice => this.totalPrice = totalPrice
    );
    
  }

  onSubmit() {
    console.log("Handling the submit button");
    
    if (this.checkoutFormGroup.invalid) {
      this.checkoutFormGroup.markAllAsTouched();
      return;
    }

    // set up order
    let order = new Order();
    order.totalPrice = this.totalPrice;
    order.totalQuantity = this.totalQuantity;

    // get cart items
    const cartItems = this.cartService.cartItems;

    // create orderItems from cartItems
    /* - long way 
    let orderItems: OrderItem[] = [];
    for (let i=0; i < cartItems.length; i++) {
      orderItems[i] = new OrderItem(cartItems[i]);
    } */

    // - short way
    let orderItems: OrderItem[] = cartItems.map(tempCartItem => new OrderItem(tempCartItem));

    //set up purchase 
    let purchase = new Purchase();
    
    // populate purchase - customer
    purchase.customer = this.checkoutFormGroup.controls['customer'].value

    // populate purchase - shipping address
    purchase.shippingAddress = this.checkoutFormGroup.controls['shippingAddress'].value;
   //const shippingProvince: Province = JSON.parse(JSON.stringify(purchase.shippingAddress.province));
   //const shippingCountry: Country = JSON.parse(JSON.stringify(purchase.shippingAddress.country));

    // populate purchase - billing address
    purchase.billingAddress = this.checkoutFormGroup.controls['billingAddress'].value;

    // populate purchase - order and orderItems
    purchase.order = order;
    purchase.orderItems = orderItems;

    // compute payment Info
    this.paymentInfo.amount = Math.round(this.totalPrice * 100);
    this.paymentInfo.currency = "ZAR"
    this.paymentInfo.recieptEmail = purchase.customer.email;

    console.log(`this.paymentInfo.amount: ${this.paymentInfo.amount}`);
    // If valid form then
    // - create payment intent
    // - confirm card payment
    // - place order

    // Code for payment processing
    if (!this.checkoutFormGroup.invalid && this.displayError.textContent == "") {
      this.isDisabled = true  // make the button functional before calling APIs
      this.checkoutService.createPaymentIntent(this.paymentInfo).subscribe(
        (paymentIntentResponse) => { // code below states "Confirm card payment on stripe.com & Send credit card data directly to stripe to stripe.com servers"
          this.stripe.confirmCardPayment(paymentIntentResponse.client_secret,
            {
              payment_method: {
                card: this.cardElement
               /* billing_details: {
                  email: purchase.customer.email,
                  name: `${purchase.customer.firstName} ${purchase.customer.lastName}`,
                  address: {
                    line1: purchase.billingAddress.street,
                    city: purchase.billingAddress.city,
                    state: purchase.billingAddress.province,
                    postal_code: purchase.billingAddress.zipCode,
                    country: purchase.billingAddress.country 
                  }
                } */
              }
            }, { handleActions: false } )
            .then(function(result) {
              if (result.error) {
                // inform the customer there was an error
                alert(`There was an error: ${result.error.message}`);
                this.isDisabled = false;
              } else {
                // call REST API via the CheckoutService
                this.checkoutService.placeOrder(purchase).subscribe({
                  next: response => {
                    alert(`Your order has been recieved.\nOrder tracking number: ${response.orderTrackingNumber}`);

                    // reset cart totals
                    this.resetCart();
                    this.isDisabled = false;
                  },
                  error: err => {
                    alert(`There was an error: ${err.message}`);
                    this.isDisabled = false;
                  }
                })
              }
            }.bind(this));
            
        }
      );
    } else {
      this.checkoutFormGroup.markAllAsTouched();
      return;
    }

    console.log(this.checkoutFormGroup.get('customer').value);
    console.log("The email  address is " + this.checkoutFormGroup.get('customer').value.email);

    
  }
  resetCart() {
    // reset cart data
    this.cartService.cartItems = [];
    this.cartService.totalPrice.next(0);
    this.cartService.totalQuantity.next(0);
    this.cartService.persistCartItems();

    // reset the form
    this.checkoutFormGroup.reset();

    // navigate back to the products page
    this.router.navigateByUrl("/products");
  }

  handleMonthsandYears() {

    const creditCardFormGroup = this.checkoutFormGroup.get('creditCard');

    const currentYear: number = new Date().getFullYear();
    const selectedYear: number = Number(creditCardFormGroup.value.exprirationYear);

    // if the current year equals the selected year, then start with the current month

    let startMonth: number;

    if (currentYear === selectedYear) {
      startMonth = new Date().getMonth() + 1;
    }
    else {
      startMonth = 1;
    }

    this.periodFormService.getCreditCardMonths(startMonth).subscribe(
      data => {
        console.log("Retrieved credit card months: " + JSON.stringify(data));
        this.creditCardMonths = data;
      }
    )
  }

  get firstName() { return this.checkoutFormGroup.get('customer.firstName');}
  get lastName() { return this.checkoutFormGroup.get('customer.lastName');}
  get email() { return this.checkoutFormGroup.get('customer.email');}

  get shippingAddressStreet() { return this.checkoutFormGroup.get('shippingAddress.street');}
  get shippingAddressCity() { return this.checkoutFormGroup.get('shippingAddress.city');}
  get shippingAddressProvince() { return this.checkoutFormGroup.get('shippingAddress.province');}
  get shippingAddressZipCode() { return this.checkoutFormGroup.get('shippingAddress.zipCode');}
  get shippingAddressCountry() { return this.checkoutFormGroup.get('shippingAddress.country');}
  
  get billingAddressStreet() { return this.checkoutFormGroup.get('billingAddress.street');}
  get billingAddressCity() { return this.checkoutFormGroup.get('billingAddress.city');}
  get billingAddressProvince() { return this.checkoutFormGroup.get('billingAddress.province');}
  get billingAddressZipCode() { return this.checkoutFormGroup.get('billingAddress.zipCode');}
  get billingAddressCountry() { return this.checkoutFormGroup.get('billingAddress.country');}

  get creditCardType() { return this.checkoutFormGroup.get('creditCard.cardType');}
  get creditCardNameOnCard() { return this.checkoutFormGroup.get('creditCard.nameOnCard');}
  get creditCardNumber() { return this.checkoutFormGroup.get('creditCard.cardNumber');}
  get creditCardSecurityCode() { return this.checkoutFormGroup.get('creditCard.securityCode');}
  get creditCardExpirationMonth() { return this.checkoutFormGroup.get('creditCard.expirationMonth');}
  get creditCardExpirationYear() { return this.checkoutFormGroup.get('creditCard.expirationYear');}
  
}
