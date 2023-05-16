import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { CartItem } from 'src/app/common/cart-item';
import { Product } from 'src/app/common/product';
import { CartService } from 'src/app/services/cart.service';
import { ProductService } from 'src/app/services/product.service';

@Component({
  selector: 'app-product-list',
  templateUrl: './product-list-for-grid.component.html',
  //templateUrl: './product-list.component.html',
  styleUrls: ['./product-list.component.css']
})
export class ProductListComponent implements OnInit {

  products: Product[];
  currentCategoryId: number = 1;
  searchMode: boolean;

  constructor(private productService: ProductService,
              private cartService: CartService, 
              private route: ActivatedRoute
              ) { }

  ngOnInit(): void {
    this.route.paramMap.subscribe(() => {
      this.listProducts();
    });
    
  }
   
  listProducts() {

    this.searchMode = this.route.snapshot.paramMap.has('keyword');

    if (this.searchMode) {
      this.handleSearchProducts();
    }
    else {
      this.handleListProducts();

    }

  }
  handleSearchProducts() {
    const theKeyword: string = this.route.snapshot.paramMap.get('keyword');

    //now search for products using keyword
    this.productService.searchProducts(theKeyword).subscribe(
      data => {
        this.products = data;
      }
    )
  }

  handleListProducts() {
          // Check if "id" parameter is available
  const hasCategoryId: boolean = this.route.snapshot.paramMap.has('id');
  
  if (hasCategoryId) {
    //get the "id" param string. convert string to a number using the "+" symbol
    this.currentCategoryId = +this.route.snapshot.paramMap.get('id');
  }
  else {
    // if category id is not available .... Then default to category id 1
    this.currentCategoryId = 1;
  }
    //now we get the product for the given category id
    this.productService.getProductList(this.currentCategoryId).subscribe(
      data => {
        this.products = data;
      }
    )

  }

  addToCart(theProduct: Product) {
    console.log(`Adding to cart: ${theProduct.name}, ${theProduct.unitPrice}`);

    //To do ... do the real work
    const theCartItem = new CartItem(theProduct)

    this.cartService.addToCart(theCartItem);

  }

}
