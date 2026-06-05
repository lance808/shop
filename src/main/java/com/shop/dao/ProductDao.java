package com.shop.dao;

import com.shop.entity.Product;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ProductDao {
    Product selectById(Integer id);

    List<Product> selectAll();

    List<Product> selectByCategoryId(Integer categoryId);

    List<Product> selectByKeyword(String keyword);

    int insert(Product product);

    int update(Product product);

    int deleteById(Integer id);

    int updateStock(@Param("id") Integer id, @Param("quantity") Integer quantity);

    List<Product> selectWithCategory(@Param("name") String name, @Param("categoryId") Integer categoryId);
}
