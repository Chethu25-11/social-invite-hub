// com/socialinvitehub/service/UserService.java
package com.socialinvitehub.service;

import com.socialinvitehub.dto.PrivacyDto;
import com.socialinvitehub.dto.ReferralInfoDto;
import com.socialinvitehub.entity.UserEntity;

public interface UserService {
    boolean register(UserEntity userEntity);
    UserEntity login(String email, String password);
    boolean updatePrivacySettings(UserEntity user, PrivacyDto dto);
    ReferralInfoDto getReferralInfo(String referralCode);
}