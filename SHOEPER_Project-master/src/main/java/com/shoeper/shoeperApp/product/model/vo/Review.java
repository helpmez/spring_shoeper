package com.shoeper.shoeperApp.product.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {

	private int review_no;
	private String review_contents;
	private Date review_date;
	private String review_title;
	private int member_no;
	private int product_no;
	private int order_no;
	private int review_rating;
	private String reviewatt_name;
}
