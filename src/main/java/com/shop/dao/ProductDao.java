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

    // 分页查询
    List<Product> selectAllWithPage(@Param("offset") int offset, @Param("limit") int limit);

    int countAll();

    List<Product> selectByCategoryIdWithPage(@Param("categoryId") Integer categoryId,
                                              @Param("offset") int offset,
                                              @Param("limit") int limit);

    int countByCategoryId(@Param("categoryId") Integer categoryId);

    List<Product> selectByKeywordWithPage(@Param("keyword") String keyword,
                                           @Param("offset") int offset,
                                           @Param("limit") int limit);

    int countByKeyword(@Param("keyword") String keyword);
}
