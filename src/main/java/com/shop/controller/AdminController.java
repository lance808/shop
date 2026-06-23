package com.shop.controller;

import com.shop.entity.Category;
import com.shop.entity.Order;
import com.shop.entity.Product;
import com.shop.service.CategoryService;
import com.shop.service.OrderService;
import com.shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private OrderService orderService;

    @RequestMapping("/index")
    public String index(Model model) {
        model.addAttribute("productCount", productService.getAll().size());
        model.addAttribute("categoryCount", categoryService.getAll().size());
        model.addAttribute("orderCount", orderService.getAll().size());
        return "admin/index";
    }

    @RequestMapping("/stats")
    public String stats(Model model) {
        model.addAttribute("productCount", productService.countByStatus(1));
        model.addAttribute("offProductCount", productService.countByStatus(0));
        model.addAttribute("totalSales", productService.sumSales());
        model.addAttribute("totalStock", productService.sumStock());
        model.addAttribute("userCount", productService.countUsers());
        model.addAttribute("pendingOrders", productService.countOrdersByStatus("pending"));
        model.addAttribute("paidOrders", productService.countOrdersByStatus("paid"));
        model.addAttribute("shippedOrders", productService.countOrdersByStatus("shipped"));
        model.addAttribute("completedOrders", productService.countOrdersByStatus("completed"));
        model.addAttribute("orderTotal", productService.sumOrderTotal());
        model.addAttribute("topProducts", productService.getTopSales(10));
        return "admin/stats";
    }

    // ==================== 商品管理 ====================

    @RequestMapping("/product/list")
    public String productList(@RequestParam(required = false) String name,
                              @RequestParam(required = false) Integer categoryId,
                              Model model) {
        List<Product> products = productService.query(name, categoryId);
        List<Category> categories = categoryService.getAll();
        model.addAttribute("products", products);
        model.addAttribute("categories", categories);
        model.addAttribute("name", name);
        model.addAttribute("categoryId", categoryId);
        return "admin/product_list";
    }

    @RequestMapping("/product/addPage")
    public String productAddPage(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "admin/product_form";
    }

    @RequestMapping("/product/editPage/{id}")
    public String productEditPage(@PathVariable("id") Integer id, Model model) {
        Product product = productService.getById(id);
        model.addAttribute("product", product);
        model.addAttribute("categories", categoryService.getAll());
        return "admin/product_form";
    }

    @RequestMapping(value = "/product/save", method = RequestMethod.POST)
    public String productSave(Product product,
                              @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                              HttpServletRequest request) {
        String uploadPath = request.getServletContext().getRealPath("/") + "uploads/";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String originalFilename = imageFile.getOriginalFilename();
                String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
                String newFilename = UUID.randomUUID().toString() + suffix;
                imageFile.transferTo(new File(uploadPath + newFilename));
                product.setImage("uploads/" + newFilename);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if (product.getId() != null && product.getId() > 0) {
            Product existing = productService.getById(product.getId());
            if (existing != null) {
                if (product.getImage() == null) {
                    product.setImage(existing.getImage());
                }
            }
            productService.update(product);
        } else {
            productService.add(product);
        }
        return "redirect:/admin/product/list";
    }

    @RequestMapping("/product/delete/{id}")
    public String productDelete(@PathVariable("id") Integer id) {
        productService.delete(id);
        return "redirect:/admin/product/list";
    }

    // ==================== 分类管理 ====================

    @RequestMapping("/category/list")
    public String categoryList(Model model) {
        List<Category> categories = categoryService.getAll();
        model.addAttribute("categories", categories);
        return "admin/category_list";
    }

    @RequestMapping("/category/addPage")
    public String categoryAddPage(Model model) {
        model.addAttribute("categories", categoryService.getAll());
        return "admin/category_form";
    }

    @RequestMapping("/category/editPage/{id}")
    public String categoryEditPage(@PathVariable("id") Integer id, Model model) {
        Category category = categoryService.getById(id);
        model.addAttribute("category", category);
        model.addAttribute("categories", categoryService.getAll());
        return "admin/category_form";
    }

    @RequestMapping(value = "/category/save", method = RequestMethod.POST)
    public String categorySave(Category category) {
        if (category.getId() != null && category.getId() > 0) {
            categoryService.update(category);
        } else {
            categoryService.add(category);
        }
        return "redirect:/admin/category/list";
    }

    @RequestMapping("/category/delete/{id}")
    public String categoryDelete(@PathVariable("id") Integer id) {
        categoryService.delete(id);
        return "redirect:/admin/category/list";
    }

    // ==================== 订单管理 ====================

    @RequestMapping("/order/list")
    public String orderList(Model model) {
        model.addAttribute("orders", orderService.getAll());
        return "admin/order_list";
    }

    @RequestMapping("/order/detail/{id}")
    public String orderDetail(@PathVariable("id") Integer id, Model model) {
        Order order = orderService.getById(id);
        model.addAttribute("order", order);
        return "admin/order_detail";
    }

    @RequestMapping("/order/ship/{id}")
    public String orderShip(@PathVariable("id") Integer id) {
        orderService.updateStatus(id, "shipped");
        return "redirect:/admin/order/list";
    }

    @RequestMapping("/order/complete/{id}")
    public String orderComplete(@PathVariable("id") Integer id) {
        orderService.updateStatus(id, "completed");
        return "redirect:/admin/order/list";
    }
}
