package com.shop.service.impl;

import com.shop.dao.CategoryDao;
import com.shop.entity.Category;
import com.shop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryDao categoryDao;

    @Override
    public List<Category> getAll() {
        return categoryDao.selectAll();
    }

    @Override
    public List<Category> getByParentId(Integer parentId) {
        return categoryDao.selectByParentId(parentId);
    }

    @Override
    public Category getById(Integer id) {
        return categoryDao.selectById(id);
    }

    @Override
    public boolean add(Category category) {
        return categoryDao.insert(category) > 0;
    }

    @Override
    public boolean update(Category category) {
        return categoryDao.update(category) > 0;
    }

    @Override
    public boolean delete(Integer id) {
        return categoryDao.deleteById(id) > 0;
    }
}
