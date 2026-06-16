// com/socialinvitehub/controller/UserController.java
package com.socialinvitehub.controller;

import com.socialinvitehub.dto.PrivacyDto;
import com.socialinvitehub.dto.ReferralInfoDto;
import com.socialinvitehub.dto.UserDto;
import com.socialinvitehub.entity.UserEntity;
import com.socialinvitehub.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /* ── PAGES ──────────────────────────────────────────────────── */

    @GetMapping("/")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    /* ── REGISTER POST ──────────────────────────────────────────── */

    @PostMapping("/register")
    public String register(UserDto dto, Model model) {

        if (!dto.getPassword().equals(dto.getConfirmPassword())) {
            model.addAttribute("error", "Passwords do not match");
            return "register";
        }

        UserEntity entity = new UserEntity();
        entity.setFullName(dto.getFullName());
        entity.setEmail(dto.getEmail());

        try {
            entity.setMobileNumber(Long.parseLong(dto.getMobileNumber()));
        } catch (NumberFormatException e) {
            model.addAttribute("error", "Invalid mobile number");
            return "register";
        }

        entity.setPassword(dto.getPassword());

        boolean saved = userService.register(entity);

        if (saved) {
            model.addAttribute("success", "Registration Successful! Please sign in.");
            return "login";
        }

        model.addAttribute("error", "Email already exists");
        return "register";
    }

    /* ── LOGIN POST ─────────────────────────────────────────────── */

    @PostMapping("/login")
    public String login(
            @RequestParam String email,
            @RequestParam String password,
            HttpSession session,
            Model model) {

        UserEntity user = userService.login(email, password);

        if (user != null) {
            session.setAttribute("loggedUser", user);
            return "redirect:/dashboard";
        }

        model.addAttribute("error", "Invalid Email or Password");
        return "login";
    }

    /* ── DASHBOARD ──────────────────────────────────────────────── */

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        UserEntity user = (UserEntity) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/";

        String inviteLink =
                "http://localhost:8080/social-invite-hub/ref?code="
                        + user.getReferralCode();

        model.addAttribute("user", user);
        model.addAttribute("inviteLink", inviteLink);
        return "dashboard";
    }

    /* ── SAVE PRIVACY SETTINGS ──────────────────────────────────── */

    @PostMapping("/privacy")
    public String savePrivacy(
            PrivacyDto dto,
            HttpSession session,
            Model model) {

        UserEntity user = (UserEntity) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/";

        boolean updated = userService.updatePrivacySettings(user, dto);

        // Refresh session with updated user
        if (updated) {
            session.setAttribute("loggedUser", user);
            model.addAttribute("privacySaved", true);
        } else {
            model.addAttribute("privacyError", "Could not save settings");
        }

        String inviteLink =
                "http://localhost:8080/social-invite-hub/ref?code="
                        + user.getReferralCode();

        model.addAttribute("user", user);
        model.addAttribute("inviteLink", inviteLink);
        return "dashboard";
    }

    /* ── REFERRAL LANDING (recipient clicks link) ───────────────── */

    @GetMapping("/ref")
    public String referralLanding(
            @RequestParam String code,
            Model model) {

        model.addAttribute("referralCode", code);
        return "referral-landing";   // new JSP
    }

    /* ── TELL ME MORE (AJAX / form POST) ───────────────────────── */

    @GetMapping("/tell-me-more")
    public String tellMeMore(
            @RequestParam String code,
            Model model) {

        ReferralInfoDto info = userService.getReferralInfo(code);

        if (info == null) {
            model.addAttribute("error", "Invalid referral link");
            return "referral-landing";
        }

        model.addAttribute("info", info);
        model.addAttribute("referralCode", code);
        return "tell-me-more";      // new JSP
    }

    /* ── LOGOUT ─────────────────────────────────────────────────── */

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}