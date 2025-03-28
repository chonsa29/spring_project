package com.example.demo.mapper;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.model.Product;
import com.example.demo.model.Review;

@Mapper
public interface ProductMapper {

	List<Product> SelectProduct(HashMap<String, Object> map);

	int CountProduct(HashMap<String, Object> map);

	Product SelectProductInfo(HashMap<String, Object> map);

	int SelectProductCount(HashMap<String, Object> map);

	int addProduct(HashMap<String, Object> map);

	void insertProductFile(HashMap<String, Object> map);

	List<Product> SelectProduct2(HashMap<String, Object> map);

	List<Product> SelectProductImgList(HashMap<String, Object> map);

	int updateProduct(HashMap<String, Object> map);

	int updateProductImage(HashMap<String, Object> map);

	int deleteProduct(HashMap<String, Object> map);

	int deleteProductImages(HashMap<String, Object> map);

	void deleteProductImg(HashMap<String, Object> map);

	void updateThumbnail(HashMap<String, Object> map);

	void insertAdditionalImage(HashMap<String, Object> map);
  
	List<Product> SelectCategory(HashMap<String, Object> map);

	List<Review> SelectProductReview(HashMap<String, Object> map);


}
