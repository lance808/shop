package com.shop.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class OrderNoUtil {

    public static String generate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
        String dateStr = sdf.format(new Date());
        Random random = new Random();
        int num = random.nextInt(9000) + 1000;
        return dateStr + num;
    }
}
