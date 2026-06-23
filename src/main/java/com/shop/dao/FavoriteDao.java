package com.shop.dao;

import com.shop.entity.Favorite;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface FavoriteDao {
    int insert(Favorite favorite);

    int delete(@Param("userId") Integer userId, @Param("productId") Integer productId);

    List<Favorite> selectByUserId(Integer userId);

    Favorite selectByUserAndProduct(@Param("userId") Integer userId, @Param("productId") Integer productId);

    int countByUserId(Integer userId);
}
