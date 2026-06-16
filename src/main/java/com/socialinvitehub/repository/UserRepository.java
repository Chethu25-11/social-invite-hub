// com/socialinvitehub/repository/UserRepository.java
package com.socialinvitehub.repository;

import com.socialinvitehub.entity.UserEntity;

public interface UserRepository {
    boolean save(UserEntity userEntity);
    UserEntity findByEmail(String email);
    UserEntity findByReferralCode(String referralCode);
    boolean update(UserEntity userEntity);
}