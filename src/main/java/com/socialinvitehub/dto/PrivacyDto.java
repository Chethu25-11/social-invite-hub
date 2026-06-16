
package com.socialinvitehub.dto;

import lombok.Data;

@Data
public class PrivacyDto {

    private String telegramHandle;
    private String instagramHandle;
    private String snapchatHandle;

    private boolean hideName;
    private boolean hideEmail;
    private boolean hideMobile;
    private boolean hideTelegram;
    private boolean hideInstagram;
    private boolean hideSnapchat;
}