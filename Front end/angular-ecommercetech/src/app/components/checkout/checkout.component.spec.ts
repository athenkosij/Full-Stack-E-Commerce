import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CheckoutComponent } from './checkout.component';

/*describe('CheckoutComponent', () => {
  let component: CheckoutComponent;
  let fixture: ComponentFixture<CheckoutComponent>; */

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CheckoutComponent ]
    })
    .compileComponents();

    const fixture = TestBed.createComponent(CheckoutComponent);
    const component = fixture.componentInstance;
    fixture.detectChanges();
  });

  /*it('should create', () => {
    expect(component).toBeTruthy();
  }); */


function expect(component: CheckoutComponent) {
  throw new Error('Function not implemented.');
}

function beforeEach(arg0: () => Promise<void>) {
  throw new Error('Function not implemented.');
}

