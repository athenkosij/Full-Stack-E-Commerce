package com.Tesla.ecommercetech.dto;

import lombok.Data;

@Data
public class PaymentInfo {

    private int amount;
    private String currency;
    private String getReceiptEmail;
}
