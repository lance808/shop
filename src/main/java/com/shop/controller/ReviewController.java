package com.shop.controller;

import com.shop.entity.Review;
import com.shop.entity.User;
import com.shop.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/review")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String add(@RequestParam Integer productId,
                      @RequestParam Integer rating,
                      @RequestParam String content,
                      HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) return "redirect:/user/login";
        Review review = new Review();
        review.setUserId(user.getId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setContent(content);
        reviewService.add(review);
        return "redirect:/product/detail/" + productId;
    }

    @RequestMapping("/list/{productId}")
    public String list(@PathVariable Integer productId, Model model) {
        model.addAttribute("reviews", reviewService.getByProductId(productId));
        model.addAttribute("reviewCount", reviewService.countByProductId(productId));
        model.addAttribute("avgRating", reviewService.avgRating(productId));
        model.addAttribute("productId", productId);
        return "review_list";
    }
}
