
package com.socialinvitehub.service;

import com.socialinvitehub.dto.PrivacyDto;
import com.socialinvitehub.dto.ReferralInfoDto;
import com.socialinvitehub.entity.UserEntity;
import com.socialinvitehub.repository.UserRepository;
import com.socialinvitehub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;

    private final BCryptPasswordEncoder passwordEncoder =
            new BCryptPasswordEncoder();

    /* ── REGISTER ──────────────────────────────────────────────── */
    @Override
    public boolean register(UserEntity userEntity) {

        UserEntity existing =
                userRepository.findByEmail(userEntity.getEmail());

        if (existing != null) {
            return false;
        }

        userEntity.setPassword(
                passwordEncoder.encode(userEntity.getPassword()));

        String referralCode = UUID.randomUUID()
                .toString()
                .replace("-", "")
                .substring(0, 10);

        userEntity.setReferralCode(referralCode);

        return userRepository.save(userEntity);
    }

    /* ── LOGIN ──────────────────────────────────────────────────── */
    @Override
    public UserEntity login(String email, String password) {

        UserEntity user = userRepository.findByEmail(email);

        if (user != null &&
                passwordEncoder.matches(password, user.getPassword())) {
            return user;
        }

        return null;
    }

    /* ── UPDATE PRIVACY SETTINGS ────────────────────────────────── */
    @Override
    public boolean updatePrivacySettings(UserEntity user, PrivacyDto dto) {

        user.setTelegramHandle(dto.getTelegramHandle());
        user.setInstagramHandle(dto.getInstagramHandle());
        user.setSnapchatHandle(dto.getSnapchatHandle());

        // dto fields are primitive boolean — safe to assign directly to Boolean wrapper
        user.setHideName(dto.isHideName());
        user.setHideEmail(dto.isHideEmail());
        user.setHideMobile(dto.isHideMobile());
        user.setHideTelegram(dto.isHideTelegram());
        user.setHideInstagram(dto.isHideInstagram());
        user.setHideSnapchat(dto.isHideSnapchat());

        return userRepository.update(user);
    }

    /* ── GET REFERRAL INFO ──────────────────────────────────────── */
    @Override
    public ReferralInfoDto getReferralInfo(String referralCode) {

        UserEntity referrer =
                userRepository.findByReferralCode(referralCode);

        if (referrer == null) {
            return null;
        }

        ReferralInfoDto info = new ReferralInfoDto();

        // Boolean.TRUE.equals() safely handles null — returns false if null
        info.setDisplayName(
                Boolean.TRUE.equals(referrer.getHideName())
                        ? "Anonymous"
                        : referrer.getFullName());

        info.setDisplayEmail(
                Boolean.TRUE.equals(referrer.getHideEmail())
                        ? "Hidden"
                        : referrer.getEmail());

        info.setDisplayMobile(
                Boolean.TRUE.equals(referrer.getHideMobile())
                        ? "Hidden"
                        : String.valueOf(referrer.getMobileNumber()));

        info.setDisplayTelegram(
                (Boolean.TRUE.equals(referrer.getHideTelegram())
                        || isNullOrEmpty(referrer.getTelegramHandle()))
                        ? "Hidden"
                        : referrer.getTelegramHandle());

        info.setDisplayInstagram(
                (Boolean.TRUE.equals(referrer.getHideInstagram())
                        || isNullOrEmpty(referrer.getInstagramHandle()))
                        ? "Hidden"
                        : referrer.getInstagramHandle());

        info.setDisplaySnapchat(
                (Boolean.TRUE.equals(referrer.getHideSnapchat())
                        || isNullOrEmpty(referrer.getSnapchatHandle()))
                        ? "Hidden"
                        : referrer.getSnapchatHandle());

        return info;
    }

    /* ── PRIVATE HELPER ─────────────────────────────────────────── */
    private boolean isNullOrEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}