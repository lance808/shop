package com.shop.service.impl;

import com.shop.dao.ReviewDao;
import com.shop.entity.Review;
import com.shop.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewServiceImpl implements ReviewService {

    @Autowired
    private ReviewDao reviewDao;

    @Override
    public boolean add(Review review) {
        return reviewDao.insert(review) > 0;
    }

    @Override
    public List<Review> getByProductId(Integer productId) {
        return reviewDao.selectByProductId(productId);
    }

    @Override
    public List<Review> getByUserId(Integer userId) {
        return reviewDao.selectByUserId(userId);
    }

    @Override
    public int countByProductId(Integer productId) {
        return reviewDao.countByProductId(productId);
    }

    @Override
    public int avgRating(Integer productId) {
        return reviewDao.avgRatingByProductId(productId);
    }
}
