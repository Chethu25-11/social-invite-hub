// com/socialinvitehub/repository/UserRepositoryImpl.java
package com.socialinvitehub.repository;

import com.socialinvitehub.entity.UserEntity;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.List;

@Repository
@Transactional
public class UserRepositoryImpl implements UserRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public boolean save(UserEntity userEntity) {
        try {
            entityManager.persist(userEntity);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public UserEntity findByEmail(String email) {
        String jpql = "SELECT u FROM UserEntity u WHERE u.email = :email";
        TypedQuery<UserEntity> query =
                entityManager.createQuery(jpql, UserEntity.class);
        query.setParameter("email", email);

        List<UserEntity> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public UserEntity findByReferralCode(String referralCode) {
        String jpql = "SELECT u FROM UserEntity u WHERE u.referralCode = :code";
        TypedQuery<UserEntity> query =
                entityManager.createQuery(jpql, UserEntity.class);
        query.setParameter("code", referralCode);

        List<UserEntity> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Override
    public boolean update(UserEntity userEntity) {
        try {
            entityManager.merge(userEntity);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}