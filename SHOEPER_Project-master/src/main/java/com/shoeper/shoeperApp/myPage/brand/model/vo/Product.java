package com.shoeper.shoeperApp.myPage.brand.model.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Setter
public class Product implements Serializable {

	private static final long serialVersionUID = 1000L;
	
	private int product_no;
	private String product_name;
	private String product_detail;
	private String product_sizeinfo;
	private String product_size;
	private int product_price;
	private int product_stock_240;
	private int product_stock_250;
	private int product_stock_260;
	private int product_stock_270;
	private int product_stock_280;
	private int product_type;
	private int member_no;
	
	private int total;
	private int rank;
	private int quantity;

}
