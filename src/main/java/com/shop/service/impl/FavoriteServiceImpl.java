package com.shop.service.impl;

import com.shop.dao.FavoriteDao;
import com.shop.entity.Favorite;
import com.shop.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FavoriteServiceImpl implements FavoriteService {

    @Autowired
    private FavoriteDao favoriteDao;

    @Override
    public boolean add(Integer userId, Integer productId) {
        Favorite existing = favoriteDao.selectByUserAndProduct(userId, productId);
        if (existing != null) {
            return false;
        }
        Favorite f = new Favorite();
        f.setUserId(userId);
        f.setProductId(productId);
        return favoriteDao.insert(f) > 0;
    }

    @Override
    public boolean remove(Integer userId, Integer productId) {
        return favoriteDao.delete(userId, productId) > 0;
    }

    @Override
    public List<Favorite> getByUserId(Integer userId) {
        return favoriteDao.selectByUserId(userId);
    }

    @Override
    public boolean isFavorited(Integer userId, Integer productId) {
        return favoriteDao.selectByUserAndProduct(userId, productId) != null;
    }

    @Override
    public int countByUserId(Integer userId) {
        return favoriteDao.countByUserId(userId);
    }
}
