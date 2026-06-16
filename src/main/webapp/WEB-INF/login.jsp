<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle"   value="Sign In"  scope="request" />
<c:set var="currentPage" value="login"    scope="request" />

<%@ include file="header.jsp" %>

<style>
    .auth-wrapper {
        min-height: calc(100vh - 62px - 66px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 48px 20px;
    }
    .auth-panel { width: 100%; max-width: 400px; }

    .auth-card {
        background: #fff;
        border-radius: var(--radius-lg);
        padding: 36px 32px;
        box-shadow: var(--shadow-md);
        border: 1px solid var(--border);
    }

    .auth-header { margin-bottom: 24px; }
    .auth-header__eyebrow {
        font-size: .75rem;
        font-weight: 600;
        letter-spacing: .06em;
        text-transform: uppercase;
        color: var(--brand);
        margin-bottom: 6px;
    }
    .auth-header__title {
        font-size: 1.35rem;
        font-weight: 800;
        color: var(--text-1);
        letter-spacing: -0.02em;
        margin-bottom: 4px;
    }
    .auth-header__sub {
        font-size: .875rem;
        color: var(--text-3);
        line-height: 1.5;
    }

    .divider {
        border: none;
        border-top: 1px solid var(--border);
        margin: 22px 0;
    }
    .auth-footer {
        text-align: center;
        font-size: .85rem;
        color: var(--text-3);
    }
    .auth-footer a {
        color: var(--brand);
        font-weight: 600;
        text-decoration: none;
    }
    .auth-footer a:hover { text-decoration: underline; }

    .input-wrapper { position: relative; }
    .input-icon {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-3);
        display: flex;
        pointer-events: none;
    }
    .input-icon svg { width: 16px; height: 16px; stroke: currentColor; fill: none; stroke-width: 2; stroke-linecap: round; stroke-linejoin: round; }
    .form-control.has-icon { padding-left: 38px; }
</style>

<div class="auth-wrapper">
    <div class="auth-panel">
        <div class="auth-card">

            <div class="auth-header">
                <p class="auth-header__eyebrow">Welcome back</p>
                <h1 class="auth-header__title">Sign in to your account</h1>
                <p class="auth-header__sub">Enter your credentials to access your dashboard.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    <c:out value="${error}" />
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
                    <c:out value="${success}" />
                </div>
            </c:if>

            <form action="login" method="post" novalidate>
                <div class="form-group">
                    <label class="form-label" for="email">Email address</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,4 12,13 22,4"/></svg>
                        </span>
                        <input class="form-control has-icon" type="email" id="email" name="email"
                               placeholder="you@example.com" autocomplete="email" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-wrapper">
                        <span class="input-icon">
                            <svg viewBox="0 0 24 24"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
                        </span>
                        <input class="form-control has-icon" type="password" id="password" name="password"
                               placeholder="Enter your password" autocomplete="current-password" required />
                    </div>
                </div>

                <button class="btn btn-primary btn-block" type="submit" style="margin-top:6px;">
                    Sign In
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </button>
            </form>

            <hr class="divider" />

            <div class="auth-footer">
                Don't have an account? <a href="register">Create one</a>
            </div>

        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>