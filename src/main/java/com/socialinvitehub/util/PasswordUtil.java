package com.socialinvitehub.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class PasswordUtil {
    private static final BCryptPasswordEncoder encoder =
            new BCryptPasswordEncoder();
    public static String encrypt(String password) {
        return encoder.encode(password);
    }
    public static boolean match(
            String rawPassword,
            String encodedPassword) {

        return encoder.matches(
                rawPassword,
                encodedPassword);
    }
}