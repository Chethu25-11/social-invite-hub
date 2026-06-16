// com/socialinvitehub/dto/UserDto.java
package com.socialinvitehub.dto;

import lombok.Data;

@Data
public class UserDto {

    private String fullName;
    private String email;
    private String mobileNumber;
    private String password;
    private String confirmPassword;

    // Social handles
    private String telegramHandle;
    private String instagramHandle;
    private String snapchatHandle;

    // Privacy toggles
    private boolean hideName;
    private boolean hideEmail;
    private boolean hideMobile;
    private boolean hideTelegram;
    private boolean hideInstagram;
    private boolean hideSnapchat;
}