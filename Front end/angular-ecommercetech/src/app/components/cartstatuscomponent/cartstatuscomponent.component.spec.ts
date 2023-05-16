import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CartstatuscomponentComponent } from './cartstatuscomponent.component';

describe('CartstatuscomponentComponent', () => {
  let component: CartstatuscomponentComponent;
  let fixture: ComponentFixture<CartstatuscomponentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CartstatuscomponentComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CartstatuscomponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
