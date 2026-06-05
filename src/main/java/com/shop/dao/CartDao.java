package com.shop.dao;

import com.shop.entity.Cart;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface CartDao {
    List<Cart> selectByUserId(Integer userId);

    Cart selectByUserIdAndProductId(@Param("userId") Integer userId, @Param("productId") Integer productId);

    int insert(Cart cart);

    int updateQuantity(@Param("id") Integer id, @Param("quantity") Integer quantity);

    int deleteById(Integer id);

    int deleteByUserId(Integer userId);

    List<Cart> selectWithProduct(Integer userId);
}
