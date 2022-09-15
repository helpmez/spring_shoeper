package com.shoeper.shoeperApp.product.model.vo;

import java.io.Serializable;
import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewAtt implements Serializable {

	private static final long serialVersionUID = 71482L;
	
	private int reviewAtt_no;			
	private String att_name;	

	private int att_level;		
	
	private int product_no;		
	private int member_no;
	

	
	private String originalFileName;
	
	public ReviewAtt(String originalFileName) {
		this.originalFileName = originalFileName;

	}
}
