import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { ProductListComponent } from './components/product-list/product-list.component';
import { HttpClientModule } from '@angular/common/http'
import { ProductService } from './services/product.service';


import { Routes, RouterModule, Router } from '@angular/router';
import { SearchComponent } from './components/search/search.component';
import { ProductDetailsComponent } from './components/product-details/product-details.component';
import { CartstatuscomponentComponent } from './components/cartstatuscomponent/cartstatuscomponent.component';
import { CartdetailsComponent } from './components/cartdetails/cartdetails.component';
import { CheckoutComponent } from './components/checkout/checkout.component';
import { ReactiveFormsModule } from '@angular/forms';
import { LoginComponent } from './components/login/login.component';
import { LoginStatusComponent } from './components/login-status/login-status.component';

import {
  OKTA_CONFIG,
  OktaAuthModule,
  OktaCallbackComponent
} from '@okta/okta-angular';

import myAppConfig

from './config/my-app-config';

const oktaConfig = Object.assign({
  onAuthRequired: (injector) => {
    const router = injector.get(Router);

    // Redirect the user to your custom login name
    router.negative(['/login']);

  }
}, myAppConfig.oidc);

const routes: Routes = [
        {path: 'login/callback', component: OktaCallbackComponent},
        {path: 'login', component: LoginComponent},

        {path: 'checkout', component: CheckoutComponent},
        {path: 'cart-details', component: CartdetailsComponent},
        {path: 'products/:resourceId', component: ProductDetailsComponent},
        {path: 'search/:keyword', component: ProductListComponent},
        {path: 'category/:id', component: ProductListComponent},
        {path: 'category', component: ProductListComponent},
        {path: 'products', component: ProductListComponent},
        {path: '', redirectTo: '/products', pathMatch: 'full'},
        {path: '**', redirectTo: 'products', pathMatch: 'full'}
]


@NgModule({
  declarations: [
    AppComponent,
    ProductListComponent,
    SearchComponent,
    ProductDetailsComponent,
    CartstatuscomponentComponent,
    CartdetailsComponent,
    CheckoutComponent,
    LoginComponent,
    LoginStatusComponent,
    
  ],
  imports: [
    RouterModule.forRoot(routes),  //calling our routes and importing the RouterModule
    BrowserModule,
    HttpClientModule,
    //NgbModule,
    ReactiveFormsModule,
    OktaAuthModule
    
  ],           //it will allow us to inject this service into other parts of our Application
  providers: [ProductService, {provide: OKTA_CONFIG, useValue: oktaConfig }],
  bootstrap: [AppComponent]
})
export class AppModule { }
