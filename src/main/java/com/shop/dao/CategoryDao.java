package com.shop.dao;

import com.shop.entity.Category;
import java.util.List;

public interface CategoryDao {
    List<Category> selectAll();

    List<Category> selectByParentId(Integer parentId);

    Category selectById(Integer id);

    int insert(Category category);

    int update(Category category);

    int deleteById(Integer id);
}
