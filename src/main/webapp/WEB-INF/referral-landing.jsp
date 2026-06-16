<%-- WEB-INF/referral-landing.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle"   value="You've Been Invited!" scope="request" />
<c:set var="currentPage" value=""                     scope="request" />

<%@ include file="header.jsp" %>

<style>
    .invite-wrapper {
        min-height: calc(100vh - 62px - 66px);
        display: flex; align-items: center; justify-content: center;
        padding: 48px 20px;
        background: linear-gradient(135deg, var(--brand-light) 0%, #fff 100%);
    }
    .invite-card {
        background: #fff;
        border-radius: 20px;
        padding: 48px 40px;
        box-shadow: 0 8px 40px rgba(108,63,235,.12);
        border: 1px solid var(--border);
        text-align: center;
        max-width: 460px;
        width: 100%;
    }
    .invite-icon  { font-size: 3rem; margin-bottom: 16px; }
    .invite-title { font-size: 1.5rem; font-weight: 800; color: var(--text-1); margin-bottom: 8px; }
    .invite-sub   { font-size: .9rem; color: var(--text-3); line-height: 1.6; margin-bottom: 32px; }

    .invite-actions { display: flex; flex-direction: column; gap: 12px; }
    .btn-block { width: 100%; }

    .btn-outline {
        display: inline-flex; align-items: center; justify-content: center;
        gap: 8px; padding: 12px 20px;
        border: 2px solid var(--border);
        border-radius: 10px; background: transparent;
        color: var(--text-2); font-weight: 600; font-size: .9rem;
        cursor: pointer; text-decoration: none;
        transition: border-color .2s, color .2s;
    }
    .btn-outline:hover { border-color: var(--brand); color: var(--brand); }

    .btn-danger-outline {
        display: inline-flex; align-items: center; justify-content: center;
        gap: 8px; padding: 12px 20px;
        border: 2px solid #fee2e2; border-radius: 10px; background: transparent;
        color: #ef4444; font-weight: 600; font-size: .9rem;
        cursor: pointer; text-decoration: none;
        transition: border-color .2s, background .2s;
    }
    .btn-danger-outline:hover { background: #fef2f2; border-color: #ef4444; }
</style>

<div class="invite-wrapper">
    <div class="invite-card">
        <div class="invite-icon">🎉</div>
        <h1 class="invite-title">Someone thinks you'd love this!</h1>
        <p class="invite-sub">
            Someone in your network thinks Social Invite Hub might be of interest to you.<br/>
            What would you like to do?
        </p>

        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <c:out value="${error}" />
            </div>
        </c:if>

        <div class="invite-actions">
            <a class="btn btn-primary btn-block"
               href="tell-me-more?code=<c:out value='${referralCode}'/>"
               style="display:flex;align-items:center;justify-content:center;gap:8px;padding:14px;">
                🙋 Tell Me More
            </a>

            <a class="btn-outline" href="register?ref=<c:out value='${referralCode}'/>">
                ✍️ Join Now (Skip reveal)
            </a>

            <a class="btn-danger-outline" href="opt-out?code=<c:out value='${referralCode}'/>">
                🚫 Never Send Me Recommendations Again
            </a>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>