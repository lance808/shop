package com.shop.service;

import com.shop.entity.Category;
import java.util.List;

public interface CategoryService {
    List<Category> getAll();

    List<Category> getByParentId(Integer parentId);

    Category getById(Integer id);

    boolean add(Category category);

    boolean update(Category category);

    boolean delete(Integer id);
}
