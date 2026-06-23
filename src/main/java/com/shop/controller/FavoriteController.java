package com.shop.controller;

import com.shop.entity.Favorite;
import com.shop.entity.User;
import com.shop.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        List<Favorite> favorites = favoriteService.getByUserId(user.getId());
        model.addAttribute("favorites", favorites);
        return "favorite_list";
    }

    @RequestMapping("/add")
    public String add(@RequestParam Integer productId, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        favoriteService.add(user.getId(), productId);
        return "redirect:/product/detail/" + productId;
    }

    @RequestMapping("/remove")
    public String remove(@RequestParam Integer productId, HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        favoriteService.remove(user.getId(), productId);
        return "redirect:/favorite/list";
    }
}
