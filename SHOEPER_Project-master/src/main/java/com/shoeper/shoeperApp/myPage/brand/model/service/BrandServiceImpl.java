package com.shoeper.shoeperApp.myPage.brand.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shoeper.shoeperApp.member.model.vo.Member;
import com.shoeper.shoeperApp.myPage.brand.model.dao.BrandDAO;
import com.shoeper.shoeperApp.myPage.brand.model.vo.MypageOrderList;
import com.shoeper.shoeperApp.myPage.brand.model.vo.O_Order;
import com.shoeper.shoeperApp.myPage.brand.model.vo.O_Order_List;
import com.shoeper.shoeperApp.product.model.vo.Attachment;
import com.shoeper.shoeperApp.product.model.vo.Product;

@Service
public class BrandServiceImpl implements BrandService {

	@Autowired
	BrandDAO brandDAO;

	@Override
	public List<Map<String, String>> selectBrandOrderList(int cPage, int numPerPage, String brand_name) {
		
		return brandDAO.selectBrandOrderList(cPage, numPerPage, brand_name);
	}

	@Override
	public List<Map<String, String>> selectBrandProductList(int cPage, int numPerPage, int member_no) {
		return brandDAO.selectBrandProductList(cPage, numPerPage, member_no);
	}

	@Override
	public int deleteBrandProductList(int productNo) {
		
		return brandDAO.deleteBrandProductList(productNo);
	}

	@Override
	public List<MypageOrderList> selectBrandOrderDetail(O_Order tempOrder) {
	
		return brandDAO.selectBrandOrderDetail(tempOrder);
	}

	@Override
	public int updateBrandInfo(Member tempMember) {
		
		return brandDAO.updateBrandInfo(tempMember);
	}

	@Override
	public int emUpdateBrandInfo(Member tempMember) {
		
		return brandDAO.emUpdateBrandInfo(tempMember);
	}

	@Override
	public int phUpdateBrandInfo(Member tempMember) {
		
		return brandDAO.phUpdateBrandInfo(tempMember);
	}

	@Override
	public int acUpdateBrandInfo(Member tempMember) {
		
		return brandDAO.acUpdateBrandInfo(tempMember);
	}

	@Override
	public List<Product> selectBrandProductRankList(int member_no) {
	
		return brandDAO.selectBrandProductRankList(member_no);
	}

	@Override
	public int updateBrandStatus(O_Order_List tempOrder) {
	
		return brandDAO.updateBrandStatus(tempOrder);
	}

	@Override
	public int brandSelectTotalContents() {
		
		return brandDAO.brandSelectTotalContents();
	}

	@Override
	public int brandProductSelectTotalContents() {
		
		return brandDAO.brandProductSelectTotalContents();

	}
	
	@Override
	public List<Attachment> selectAttachmentList(int productNo) {

		return brandDAO.selectAttachmentList(productNo);

	}
	
}


