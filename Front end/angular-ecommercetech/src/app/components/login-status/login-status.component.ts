import { Component, OnInit } from '@angular/core';
import { OktaAuth } from '@okta/okta-auth-js';

@Component({
  selector: 'app-login-status',
  templateUrl: './login-status.component.html',
  styleUrls: ['./login-status.component.css']
})
export class LoginStatusComponent implements OnInit {

  isAuthenticated: boolean = false;
  userFullName: string;

  constructor(private oktaAuthService: OktaAuth) { }

  ngOnInit(): void {

    // subscribe to the authentication state change
    this.oktaAuthService.authStateManager.subscribe(
      (result) => {
        this.isAuthenticated = result;
        this.getUserDetails();
      }
    )
  }
  getUserDetails() {
    if (this.isAuthenticated) {

      // fetch the logged in user details (user's claims)

      // user full name is exposed as a property name
      this.oktaAuthService.getUser().then(
        (res) => {
          this.userFullName = res.name;
        }
      );
    }
    
  }

  logout() {
    // terminate the session with Okta and removes cureent tokens
    
  }

}
