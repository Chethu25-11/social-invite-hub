<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle"   value="Register"  scope="request" />
<c:set var="currentPage" value="register"  scope="request" />

<%@ include file="header.jsp" %>

<style>
    .auth-wrapper {
        min-height: calc(100vh - 62px - 66px);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 48px 20px;
    }
    .auth-panel { width: 100%; max-width: 460px; }

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

    /* Steps */
    .steps {
        display: flex;
        align-items: center;
        gap: 0;
        margin-bottom: 26px;
        padding: 14px 16px;
        background: var(--bg);
        border-radius: var(--radius-md);
        border: 1px solid var(--border);
    }
    .step {
        display: flex;
        align-items: center;
        gap: 8px;
        flex: 1;
    }
    .step__num {
        width: 22px;
        height: 22px;
        border-radius: 50%;
        background: var(--brand-light);
        color: var(--brand);
        font-size: .72rem;
        font-weight: 700;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }
    .step__label {
        font-size: .8rem;
        font-weight: 500;
        color: var(--text-2);
        white-space: nowrap;
    }
    .step-sep {
        color: var(--border);
        font-size: 1.1rem;
        margin: 0 8px;
        flex-shrink: 0;
    }

    .form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 14px;
    }
    @media (max-width: 480px) { .form-row { grid-template-columns: 1fr; } }

    .form-hint { font-size: .775rem; color: var(--text-3); margin-top: 5px; }

    .strength-bar {
        height: 3px;
        border-radius: 99px;
        background: var(--border);
        margin-top: 8px;
        overflow: hidden;
    }
    .strength-bar__fill {
        height: 100%;
        border-radius: 99px;
        width: 0;
        transition: width .3s, background .3s;
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
</style>

<div class="auth-wrapper">
    <div class="auth-panel">
        <div class="auth-card">

            <div class="auth-header">
                <p class="auth-header__eyebrow">Get started</p>
                <h1 class="auth-header__title">Create your account</h1>
                <p class="auth-header__sub">Join Social Invite Hub and start sharing your unique link.</p>
            </div>

            <div class="steps">
                <div class="step">
                    <span class="step__num">1</span>
                    <span class="step__label">Register</span>
                </div>
                <span class="step-sep">›</span>
                <div class="step">
                    <span class="step__num">2</span>
                    <span class="step__label">Get invite link</span>
                </div>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="flex-shrink:0"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                    <c:out value="${error}" />
                </div>
            </c:if>

            <form action="register" method="post" novalidate id="registerForm">

                <div class="form-group">
                    <label class="form-label" for="fullName">Full name</label>
                    <input class="form-control" type="text" id="fullName" name="fullName"
                           placeholder="John Doe" autocomplete="name" required />
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="email">Email address</label>
                        <input class="form-control" type="email" id="email" name="email"
                               placeholder="you@example.com" autocomplete="email" required />
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="mobileNumber">Mobile number</label>
                        <input class="form-control" type="tel" id="mobileNumber" name="mobileNumber"
                               placeholder="9876543210" autocomplete="tel" maxlength="10" required />
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input class="form-control" type="password" id="password" name="password"
                           placeholder="Create a strong password" autocomplete="new-password"
                           required oninput="checkStrength(this.value)" />
                    <div class="strength-bar">
                        <div class="strength-bar__fill" id="strengthBar"></div>
                    </div>
                    <p class="form-hint" id="strengthLabel">Use 8+ characters with letters &amp; numbers</p>
                </div>

                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm password</label>
                    <input class="form-control" type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Repeat your password" autocomplete="new-password" required />
                </div>

                <button class="btn btn-primary btn-block" type="submit" style="margin-top:6px;">
                    Create Account
                    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/></svg>
                </button>

            </form>

            <hr class="divider" />

            <div class="auth-footer">
                Already have an account? <a href="/">Sign in</a>
            </div>

        </div>
    </div>
</div>

<script>
(function () {
    function checkStrength(val) {
        var bar   = document.getElementById('strengthBar');
        var label = document.getElementById('strengthLabel');
        var score = 0;
        if (val.length >= 8)          score++;
        if (/[A-Z]/.test(val))        score++;
        if (/[0-9]/.test(val))        score++;
        if (/[^A-Za-z0-9]/.test(val)) score++;

        var widths  = ['0%','25%','50%','75%','100%'];
        var colors  = ['#F04438','#F79009','#EAB308','#22C55E','#16A34A'];
        var labels  = ['Too short','Weak – add uppercase','Fair – add numbers','Good – add symbols','Strong ✓'];
        bar.style.width      = widths[score];
        bar.style.background = colors[score];
        label.textContent    = labels[score];
    }
    window.checkStrength = checkStrength;
}());
</script>

<%@ include file="footer.jsp" %>