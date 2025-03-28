package com.example.demo.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.mapper.ProductMapper;
import com.example.demo.model.Product;
import com.example.demo.model.Review;

@Service
public class ProductService {
	@Autowired
	ProductMapper productMapper;

	// 리스트 가져오기
	public HashMap<String, Object> productList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list = productMapper.SelectProduct(map);
			int count = productMapper.CountProduct(map);
			List<Product> category = productMapper.SelectCategory(map);
			resultMap.put("list", list);
			resultMap.put("count", count);
			resultMap.put("category", category);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	// (페이징 제외) 리스트 가져오기
	public HashMap<String, Object> productList2(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Product> list = productMapper.SelectProduct2(map);
			resultMap.put("list", list);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	// 상세정보 가져오기
	public HashMap<String, Object> productInfo(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Product info = productMapper.SelectProductInfo(map);
			int count = productMapper.SelectProductCount(map);
			List<Product> imgList = productMapper.SelectProductImgList(map);
			
			resultMap.put("imgList", imgList); 
			resultMap.put("count", count); 
			resultMap.put("info", info); 
			
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("result", "fail");
		}
		return resultMap;
	}

	// 상품 추가하기
	public HashMap<String, Object> productAdd(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		int num = productMapper.addProduct(map);
		if (num > 0) {
			resultMap.put("itemNo", map.get("itemNo"));
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	
	// 상품의 이미지 추가하기
	public void addProductFile(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		try {
			productMapper.insertProductFile(map);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}

	public HashMap<String, Object> productUpdate(HashMap<String, Object> map) {
        HashMap<String, Object> resultMap = new HashMap<>();

        try {
            int num = productMapper.updateProduct(map);
            if (num > 0) {
    			resultMap.put("itemNo", map.get("itemNo"));
                resultMap.put("result", "success");
            } else {
                resultMap.put("result", "fail");
            }
        } catch (Exception e) {
            resultMap.put("result", "fail");
            System.out.println(e.getMessage());
        }

        return resultMap;
    }
	
	public void updateProductFile(HashMap<String, Object> map) {  
	    if ("Y".equals(map.get("thumbNail"))) {  
	        // 썸네일은 UPDATE  
	        productMapper.updateThumbnail(map);  
	    } else {  
	        // 추가 이미지는 무조건 INSERT  
	        productMapper.insertAdditionalImage(map);  
	    }  
	}  
	public HashMap<String, Object> productDelete(HashMap<String, Object> map) {
	    HashMap<String, Object> resultMap = new HashMap<>();
	    try {
	        productMapper.deleteProduct(map);
	        productMapper.deleteProductImages(map);
	        
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.out.println(e.getMessage());
	    }
	    return resultMap;
	}

	public HashMap<String, Object> productDeleteImg(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
	    HashMap<String, Object> resultMap = new HashMap<>();
	    try {
	        productMapper.deleteProductImg(map);
	        
	        resultMap.put("result", "success");
	    } catch (Exception e) {
	        resultMap.put("result", "fail");
	        System.out.println(e.getMessage());
	    }
	    return resultMap;
	}

	public HashMap<String, Object> productReview(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<Review> review = productMapper.SelectProductReview(map);
			resultMap.put("review", review);
			resultMap.put("result", "success");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
}
