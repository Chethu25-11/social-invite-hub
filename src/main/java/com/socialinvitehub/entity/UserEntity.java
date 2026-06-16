// com/socialinvitehub/entity/UserEntity.java
package com.socialinvitehub.entity;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@Entity
@Table(name = "users")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "email", nullable = false, unique = true)
    private String email;

    @Column(name = "mobile_number", nullable = false, unique = true)
    private Long mobileNumber;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "referral_code", unique = true)
    private String referralCode;

    @Column(name = "telegram_handle")
    private String telegramHandle;

    @Column(name = "instagram_handle")
    private String instagramHandle;

    @Column(name = "snapchat_handle")
    private String snapchatHandle;

    // ── Use Boolean (wrapper) not boolean (primitive)
    // ── so NULL from DB maps to null in Java, not a crash
    @Column(name = "hide_name", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideName = false;

    @Column(name = "hide_email", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideEmail = false;

    @Column(name = "hide_mobile", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideMobile = false;

    @Column(name = "hide_telegram", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideTelegram = false;

    @Column(name = "hide_instagram", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideInstagram = false;

    @Column(name = "hide_snapchat", columnDefinition = "BIT DEFAULT 0")
    private Boolean hideSnapchat = false;

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();
}