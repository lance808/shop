package com.shop.service;

import com.shop.entity.Favorite;
import java.util.List;

public interface FavoriteService {
    boolean add(Integer userId, Integer productId);

    boolean remove(Integer userId, Integer productId);

    List<Favorite> getByUserId(Integer userId);

    boolean isFavorited(Integer userId, Integer productId);

    int countByUserId(Integer userId);
}
