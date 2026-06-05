package com.shop.controller;

import com.shop.entity.Cart;
import com.shop.entity.Order;
import com.shop.entity.User;
import com.shop.service.CartService;
import com.shop.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    @RequestMapping("/confirm")
    public String confirm(@RequestParam("cartIds") String cartIdsStr,
                          HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        List<Cart> allCarts = cartService.getByUserId(user.getId());
        List<Cart> selectedCarts = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        String[] ids = cartIdsStr.split(",");
        for (String idStr : ids) {
            Integer cartId = Integer.parseInt(idStr.trim());
            for (Cart cart : allCarts) {
                if (cart.getId().equals(cartId)) {
                    selectedCarts.add(cart);
                    total = total.add(cart.getProductPrice().multiply(new BigDecimal(cart.getQuantity())));
                    break;
                }
            }
        }

        if (selectedCarts.isEmpty()) {
            return "redirect:/cart/list";
        }

        model.addAttribute("carts", selectedCarts);
        model.addAttribute("total", total);
        model.addAttribute("cartIds", cartIdsStr);
        return "order_confirm";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String create(Order order, @RequestParam("cartIds") String cartIdsStr,
                         HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        order.setUserId(user.getId());

        List<Integer> cartIdList = new ArrayList<>();
        for (String idStr : cartIdsStr.split(",")) {
            cartIdList.add(Integer.parseInt(idStr.trim()));
        }

        try {
            orderService.create(order, cartIdList);
            return "redirect:/order/list";
        } catch (RuntimeException e) {
            model.addAttribute("error", e.getMessage());
            return "redirect:/cart/list";
        }
    }

    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        model.addAttribute("orders", orderService.getByUserId(user.getId()));
        return "order_list";
    }

    @RequestMapping("/detail/{id}")
    public String detail(@PathVariable("id") Integer id, Model model) {
        Order order = orderService.getById(id);
        model.addAttribute("order", order);
        return "order_detail";
    }

    @RequestMapping("/cancel/{id}")
    public String cancel(@PathVariable("id") Integer id, Model model) {
        boolean result = orderService.cancel(id);
        if (!result) {
            model.addAttribute("error", "订单取消失败");
        }
        return "redirect:/order/list";
    }

    @RequestMapping("/pay/{id}")
    public String pay(@PathVariable("id") Integer id) {
        orderService.updateStatus(id, "paid");
        return "redirect:/order/list";
    }
}
