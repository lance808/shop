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

    private static final int PAGE_SIZE = 25;

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @RequestMapping("/")
    public String index(@RequestParam(defaultValue = "1") int page, Model model) {
        int total = productService.countAll();
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;

        List<Category> categories = categoryService.getAll();
        List<Product> products = productService.getAll(offset, PAGE_SIZE);

        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("total", total);
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
                       @RequestParam(defaultValue = "1") int page,
                       Model model) {
        List<Category> categories = categoryService.getAll();
        List<Product> products;
        int total;
        int totalPages;

        if (keyword != null && !keyword.trim().isEmpty()) {
            String kw = keyword.trim();
            total = productService.countByKeyword(kw);
            totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
            int offset = (page - 1) * PAGE_SIZE;
            products = productService.search(kw, offset, PAGE_SIZE);
        } else if (categoryId != null && categoryId > 0) {
            total = productService.countByCategoryId(categoryId);
            totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
            int offset = (page - 1) * PAGE_SIZE;
            products = productService.getByCategoryId(categoryId, offset, PAGE_SIZE);
        } else {
            total = productService.countAll();
            totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
            int offset = (page - 1) * PAGE_SIZE;
            products = productService.getAll(offset, PAGE_SIZE);
        }

        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        model.addAttribute("categoryId", categoryId);
        model.addAttribute("keyword", keyword);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("total", total);
        return "product_list";
    }

    @RequestMapping("/search")
    public String search(@RequestParam("keyword") String keyword,
                         @RequestParam(defaultValue = "1") int page,
                         Model model) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return "redirect:/";
        }
        String kw = keyword.trim();
        int total = productService.countByKeyword(kw);
        int totalPages = (int) Math.ceil((double) total / PAGE_SIZE);
        int offset = (page - 1) * PAGE_SIZE;
        List<Product> products = productService.search(kw, offset, PAGE_SIZE);
        List<Category> categories = categoryService.getAll();
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);
        model.addAttribute("keyword", kw);
        model.addAttribute("page", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("total", total);
        return "product_list";
    }
}
