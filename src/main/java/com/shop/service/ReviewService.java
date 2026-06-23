package com.shop.service;

import com.shop.entity.Review;
import java.util.List;

public interface ReviewService {
    boolean add(Review review);

    List<Review> getByProductId(Integer productId);

    List<Review> getByUserId(Integer userId);

    int countByProductId(Integer productId);

    int avgRating(Integer productId);
}
