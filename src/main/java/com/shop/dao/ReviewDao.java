package com.shop.dao;

import com.shop.entity.Review;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ReviewDao {
    int insert(Review review);

    List<Review> selectByProductId(@Param("productId") Integer productId);

    List<Review> selectByUserId(@Param("userId") Integer userId);

    int countByProductId(@Param("productId") Integer productId);

    int avgRatingByProductId(@Param("productId") Integer productId);
}
