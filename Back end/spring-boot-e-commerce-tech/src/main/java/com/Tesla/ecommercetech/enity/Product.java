package com.Tesla.ecommercetech.enity;

import lombok.Data;


import javax.persistence.*;
import java.math.BigDecimal;


@Entity // Specifies that a class is an  entity and is mapped to a database table.
@Table(name = "product") //Specifies the name of the database table to be used for mapping
@Data

public class Product {

        //adding JPA mappings between fields and columns
        @Id // annotation specifies the primary key of an Entity table
        @GeneratedValue(strategy = GenerationType.IDENTITY) //can be used to specify generation Type(IDENTITY, SEQUENCE, AUTO)
        @Column(name = "id")
        private Long id;

        @ManyToOne //Many products sent to One Category / Many PRODUCTS mapped to One CATEGORY
        @JoinColumn(name = "category_id", nullable = false) //@JoinColumn - we placing a foreign Key (Indicates that a given column is the owner Enity refers to a primary key in the reference Table
        private ProductCategory category; //Creating a variable that will represent the Parent class of in this CHILD CLASS


        @Column(name = "name")
        private String name;

        @Column(name = "description")
        private String description;

        @Column(name = "unit_price")
        private BigDecimal unitPrice;

        @Column(name = "imageUrl")
        private String imageUrl;

        public Long getResourceId() {
                return id;
        }


    }


