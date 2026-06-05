package com.shop.controller;

import com.shop.entity.Category;
import com.shop.entity.Product;
import com.shop.service.CategoryService;
import com.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/")
    public String index(Model model) {
        List<Category> categories = categoryService.getAll();
        List<Product> products = productService.getAll();
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        return "index";
    }

    @RequestMapping("/product/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        Product product = productService.getById(id);
        if (product == null) {
            return "redirect:/";
        }
        model.addAttribute("product", product);
        return "product_detail";
    }

    @RequestMapping("/product/list")
    public String list(@RequestParam(required = false) Integer categoryId,
                       @RequestParam(required = false) String keyword,
                       Model model) {
        List<Category> categories = categoryService.getAll();
        List<Product> products;
        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productService.search(keyword.trim());
        } else if (categoryId != null && categoryId > 0) {
            products = productService.getByCategoryId(categoryId);
        } else {
            products = productService.getAll();
        }
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("keyword", keyword);
        return "product_list";
    }

    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword, Model model) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/";
        }
        List<Product> products = productService.search(keyword.trim());
        List<Category> categories = categoryService.getAll();
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        model.addAttribute("keyword", keyword);
        return "product_list";
    }
}
