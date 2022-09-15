package com.shoeper.shoeperApp.order.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order implements Serializable{

	private static final long serialVersionUID = 401L;
	


	
	// 결제완료시 input을 위한 order data
	private int order_no;
	private String receiver_name;
	private String order_address;
	private Date order_date;
	private String order_memo;
	private int total_price;
	private int member_no;



	
	
	
	
	
     
}
