<%-- WEB-INF/dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle"   value="Dashboard"  scope="request" />
<c:set var="currentPage" value="dashboard"  scope="request" />

<%@ include file="header.jsp" %>

<style>
    /* ── layout ── */
    .dashboard-hero {
        background: var(--brand);
        padding: 40px 24px 64px;
        text-align: center;
        color: #fff;
    }
    .dashboard-hero__title {
        font-size: 1.75rem; font-weight: 800;
        letter-spacing: -0.02em; margin-bottom: 6px;
    }
    .dashboard-hero__sub { font-size: .9rem; opacity: .85; }

    .dashboard-body {
        max-width: 860px;
        margin: -36px auto 60px;
        padding: 0 20px;
    }

    /* ── cards ── */
    .card {
        background: #fff;
        border-radius: 16px;
        padding: 28px 30px;
        border: 1px solid var(--border);
        box-shadow: 0 4px 24px rgba(108,63,235,.08);
        margin-bottom: 20px;
    }
    .card__title { font-size: 1rem; font-weight: 800; color: var(--text-1); margin-bottom: 3px; }
    .card__sub   { font-size: .825rem; color: var(--text-3); }
    .card__header { margin-bottom: 18px; }

    /* ── invite link row ── */
    .link-row {
        display: flex; gap: 10px; align-items: center;
        background: var(--bg); border: 1.5px solid var(--border);
        border-radius: 10px; padding: 12px 16px; margin-bottom: 20px;
    }
    .link-row__input {
        flex: 1; border: none; background: transparent;
        color: var(--brand); font-weight: 600; font-size: .9rem;
        outline: none; min-width: 0; overflow: hidden;
        text-overflow: ellipsis; white-space: nowrap;
    }
    .link-row__copy {
        flex-shrink: 0; background: var(--brand); color: #fff;
        border: none; border-radius: 8px; padding: 9px 18px;
        font-weight: 700; font-size: .85rem; cursor: pointer;
        transition: background .2s, transform .1s; white-space: nowrap;
    }
    .link-row__copy:hover  { background: var(--brand-dark); }
    .link-row__copy:active { transform: scale(.97); }

    /* ── share buttons ── */
    .share-grid { display: flex; flex-wrap: wrap; gap: 10px; }
    .share-btn {
        display: inline-flex; align-items: center; gap: 7px;
        padding: 9px 16px; border: 1.5px solid var(--border);
        border-radius: 10px; text-decoration: none;
        color: var(--text-1); font-weight: 600; font-size: .825rem;
        transition: border-color .2s, color .2s, transform .15s;
    }
    .share-btn:hover { border-color: var(--brand); color: var(--brand); transform: translateY(-2px); }

    /* ── account table ── */
    .info-table { width: 100%; border-collapse: collapse; font-size: .9rem; }
    .info-table tr  { border-bottom: 1px solid var(--bg); }
    .info-table tr:last-child { border-bottom: none; }
    .info-table td  { padding: 11px 0; vertical-align: middle; }
    .info-table td:first-child {
        color: var(--text-3); font-size: .8rem; font-weight: 600;
        text-transform: uppercase; letter-spacing: .04em; width: 160px;
    }
    .info-table td:last-child { font-weight: 600; color: var(--text-1); }
    .info-badge {
        display: inline-block; background: #f0fdf4; color: #16a34a;
        border: 1px solid #bbf7d0; font-size: .75rem; font-weight: 700;
        padding: 2px 10px; border-radius: 99px;
    }

    /* ── privacy form ── */
    .privacy-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 12px 24px;
    }
    @media (max-width: 600px) { .privacy-grid { grid-template-columns: 1fr; } }

    .privacy-item {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 10px 14px;
        border: 1.5px solid var(--border);
        border-radius: 10px;
        background: var(--bg);
        transition: border-color .2s;
    }
    .privacy-item:has(input:checked) { border-color: var(--brand); background: var(--brand-light); }

    .privacy-item input[type="checkbox"] {
        width: 17px; height: 17px;
        accent-color: var(--brand);
        cursor: pointer;
        flex-shrink: 0;
    }
    .privacy-item label {
        font-size: .875rem; font-weight: 600;
        color: var(--text-1); cursor: pointer; flex: 1;
    }

    .handle-row {
        display: flex; align-items: center; gap: 8px;
        margin-top: 6px;
    }
    .handle-row input[type="text"] {
        flex: 1;
        border: 1.5px solid var(--border);
        border-radius: 8px;
        padding: 7px 12px;
        font-size: .85rem;
        color: var(--text-1);
        background: #fff;
        outline: none;
        transition: border-color .2s;
    }
    .handle-row input[type="text"]:focus { border-color: var(--brand); }

    /* ── toast ── */
    .toast {
        position: fixed; bottom: 28px; right: 28px;
        background: var(--text-1); color: #fff;
        padding: 13px 22px; border-radius: 10px;
        font-size: .875rem; font-weight: 600;
        opacity: 0; transform: translateY(12px);
        transition: opacity .25s, transform .25s;
        pointer-events: none; z-index: 999;
        box-shadow: 0 4px 20px rgba(0,0,0,.25);
    }
    .toast.show { opacity: 1; transform: translateY(0); }
</style>

<!-- HERO -->
<div class="dashboard-hero">
    <p style="font-size:.85rem;opacity:.75;margin-bottom:10px;font-weight:600;letter-spacing:.05em;text-transform:uppercase;">Dashboard</p>
    <h1 class="dashboard-hero__title">Welcome back, <c:out value="${user.fullName}" />! 👋</h1>
    <p class="dashboard-hero__sub">Share your link below and earn rewards when friends join.</p>
</div>

<div class="dashboard-body">

    <!-- SUCCESS / ERROR ALERTS -->
    <c:if test="${privacySaved}">
        <div class="alert alert-success" role="alert">
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
            Privacy settings saved successfully!
        </div>
    </c:if>
    <c:if test="${not empty privacyError}">
        <div class="alert alert-danger" role="alert">
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
            <c:out value="${privacyError}" />
        </div>
    </c:if>

    <!-- INVITE LINK -->
    <div class="card">
        <div class="card__header">
            <div class="card__title">Your Invite Link</div>
            <div class="card__sub">Copy and share on any platform to start earning</div>
        </div>

        <div class="link-row">
            <input class="link-row__input" type="text" id="inviteLink"
                   value="<c:out value='${inviteLink}'/>" readonly aria-label="Your invite link" />
            <button class="link-row__copy" onclick="copyLink()">📋 Copy Link</button>
        </div>

        <div class="share-grid">
            <a class="share-btn"
               href="https://wa.me/?text=Hey!%20Join%20me%20on%20Social%20Invite%20Hub%20using%20my%20link:%20<c:out value='${inviteLink}'/>"
               target="_blank" rel="noopener noreferrer">💬 WhatsApp</a>
            <a class="share-btn"
               href="https://t.me/share/url?url=<c:out value='${inviteLink}'/>&text=Join%20me%20on%20Social%20Invite%20Hub!"
               target="_blank" rel="noopener noreferrer">✈️ Telegram</a>
            <a class="share-btn"
               href="https://www.facebook.com/sharer/sharer.php?u=<c:out value='${inviteLink}'/>"
               target="_blank" rel="noopener noreferrer">📘 Facebook</a>
            <a class="share-btn"
               href="https://twitter.com/intent/tweet?text=Join%20me%20using%20my%20link:%20<c:out value='${inviteLink}'/>"
               target="_blank" rel="noopener noreferrer">🐦 X / Twitter</a>
            <a class="share-btn"
               href="mailto:?subject=Join%20Social%20Invite%20Hub&body=Hey!%20Sign%20up%20using%20my%20invite%20link:%20<c:out value='${inviteLink}'/>"
               >📧 Email</a>
        </div>
    </div>

    <!-- PRIVACY / IDENTITY SETTINGS -->
    <div class="card">
        <div class="card__header">
            <div class="card__title">🔒 Identity Privacy Settings</div>
            <div class="card__sub">Control what recipients see when they click "Tell Me More" on your invite</div>
        </div>

        <form action="privacy" method="post">
            <div class="privacy-grid">

                <!-- Hide Name -->
                <div class="privacy-item">
                    <input type="checkbox" id="hideName" name="hideName" value="true"
                           <c:if test="${user.hideName}">checked</c:if> />
                    <label for="hideName">Hide my name</label>
                </div>

                <!-- Hide Email -->
                <div class="privacy-item">
                    <input type="checkbox" id="hideEmail" name="hideEmail" value="true"
                           <c:if test="${user.hideEmail}">checked</c:if> />
                    <label for="hideEmail">Hide my email</label>
                </div>

                <!-- Hide Mobile -->
                <div class="privacy-item">
                    <input type="checkbox" id="hideMobile" name="hideMobile" value="true"
                           <c:if test="${user.hideMobile}">checked</c:if> />
                    <label for="hideMobile">Hide my mobile number</label>
                </div>

            </div>

            <!-- Social handles with hide toggle -->
            <div style="margin-top:16px; display:flex; flex-direction:column; gap:12px;">

                <div class="privacy-item" style="flex-direction:column; align-items:flex-start; gap:6px;">
                    <div style="display:flex; align-items:center; gap:10px; width:100%;">
                        <input type="checkbox" id="hideTelegram" name="hideTelegram" value="true"
                               <c:if test="${user.hideTelegram}">checked</c:if> />
                        <label for="hideTelegram" style="margin:0;">Hide my Telegram handle</label>
                    </div>
                    <div class="handle-row">
                        <span style="font-size:.8rem;color:var(--text-3);width:20px;">✈️</span>
                        <input type="text" name="telegramHandle"
                               placeholder="@your_telegram"
                               value="<c:out value='${user.telegramHandle}'/>" />
                    </div>
                </div>

                <div class="privacy-item" style="flex-direction:column; align-items:flex-start; gap:6px;">
                    <div style="display:flex; align-items:center; gap:10px; width:100%;">
                        <input type="checkbox" id="hideInstagram" name="hideInstagram" value="true"
                               <c:if test="${user.hideInstagram}">checked</c:if> />
                        <label for="hideInstagram" style="margin:0;">Hide my Instagram handle</label>
                    </div>
                    <div class="handle-row">
                        <span style="font-size:.8rem;color:var(--text-3);width:20px;">📸</span>
                        <input type="text" name="instagramHandle"
                               placeholder="@your_instagram"
                               value="<c:out value='${user.instagramHandle}'/>" />
                    </div>
                </div>

                <div class="privacy-item" style="flex-direction:column; align-items:flex-start; gap:6px;">
                    <div style="display:flex; align-items:center; gap:10px; width:100%;">
                        <input type="checkbox" id="hideSnapchat" name="hideSnapchat" value="true"
                               <c:if test="${user.hideSnapchat}">checked</c:if> />
                        <label for="hideSnapchat" style="margin:0;">Hide my Snapchat handle</label>
                    </div>
                    <div class="handle-row">
                        <span style="font-size:.8rem;color:var(--text-3);width:20px;">👻</span>
                        <input type="text" name="snapchatHandle"
                               placeholder="@your_snapchat"
                               value="<c:out value='${user.snapchatHandle}'/>" />
                    </div>
                </div>

            </div>

            <button class="btn btn-primary" type="submit" style="margin-top:20px;">
                💾 Save Privacy Settings
            </button>
        </form>
    </div>

    <!-- ACCOUNT DETAILS -->
    <div class="card">
        <div class="card__header">
            <div class="card__title">Your Account</div>
            <div class="card__sub">Your registered details</div>
        </div>
        <table class="info-table">
            <tr><td>Full Name</td>    <td><c:out value="${user.fullName}" /></td></tr>
            <tr><td>Email Address</td><td><c:out value="${user.email}" /></td></tr>
            <tr><td>Mobile Number</td><td><c:out value="${user.mobileNumber}" /></td></tr>
            <tr><td>Referral Code</td><td><c:out value="${user.referralCode}" /></td></tr>
            <tr><td>Account Status</td><td><span class="info-badge">Active</span></td></tr>
        </table>
    </div>

</div>

<div class="toast" id="toast" role="status" aria-live="polite">✅ Invite link copied!</div>

<script>
(function () {
    function copyLink() {
        var input = document.getElementById('inviteLink');
        input.select();
        input.setSelectionRange(0, 99999);
        navigator.clipboard.writeText(input.value).then(function () {
            showToast('✅ Invite link copied!');
        }).catch(function () {
            document.execCommand('copy');
            showToast('✅ Invite link copied!');
        });
    }
    function showToast(msg) {
        var toast = document.getElementById('toast');
        toast.textContent = msg;
        toast.classList.add('show');
        setTimeout(function () { toast.classList.remove('show'); }, 2500);
    }
    window.copyLink = copyLink;
}());
</script>

<%@ include file="footer.jsp" %>