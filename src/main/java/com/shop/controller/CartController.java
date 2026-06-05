package com.shop.controller;

import com.shop.entity.Cart;
import com.shop.entity.User;
import com.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        model.addAttribute("carts", cartService.getByUserId(user.getId()));
        return "cart_list";
    }

    @RequestMapping("/add")
    public String add(@RequestParam("productId") Integer productId,
                      @RequestParam(value = "quantity", defaultValue = "1") Integer quantity,
                      HttpSession session, RedirectAttributes redirectAttributes) {
        User user = (User) session.getAttribute("loginUser");
        Cart cart = new Cart();
        cart.setUserId(user.getId());
        cart.setProductId(productId);
        cart.setQuantity(quantity);
        cartService.add(cart);
        redirectAttributes.addFlashAttribute("msg", "已加入购物车");
        return "redirect:/cart/list";
    }

    @RequestMapping("/update/{id}")
    public String update(@PathVariable("id") Integer id,
                         @RequestParam("quantity") Integer quantity) {
        cartService.updateQuantity(id, quantity);
        return "redirect:/cart/list";
    }

    @RequestMapping("/delete/{id}")
    public String delete(@PathVariable("id") Integer id) {
        cartService.delete(id);
        return "redirect:/cart/list";
    }
}
