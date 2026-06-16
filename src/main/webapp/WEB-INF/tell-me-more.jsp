<%-- WEB-INF/tell-me-more.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle"   value="About Your Referrer" scope="request" />
<c:set var="currentPage" value=""                    scope="request" />

<%@ include file="header.jsp" %>

<style>
    .info-wrapper {
        min-height: calc(100vh - 62px - 66px);
        display: flex; align-items: center; justify-content: center;
        padding: 48px 20px;
    }
    .info-card {
        background: #fff;
        border-radius: 20px;
        padding: 40px 36px;
        box-shadow: 0 8px 40px rgba(108,63,235,.10);
        border: 1px solid var(--border);
        max-width: 480px;
        width: 100%;
    }
    .info-card__icon  { font-size: 2.5rem; margin-bottom: 12px; }
    .info-card__title { font-size: 1.3rem; font-weight: 800; color: var(--text-1); margin-bottom: 6px; }
    .info-card__sub   { font-size: .875rem; color: var(--text-3); margin-bottom: 28px; }

    .referrer-table { width: 100%; border-collapse: collapse; font-size: .9rem; margin-bottom: 28px; }
    .referrer-table tr  { border-bottom: 1px solid var(--bg); }
    .referrer-table tr:last-child { border-bottom: none; }
    .referrer-table td  { padding: 12px 0; vertical-align: middle; }
    .referrer-table td:first-child {
        color: var(--text-3); font-size: .78rem; font-weight: 600;
        text-transform: uppercase; letter-spacing: .04em; width: 140px;
    }
    .referrer-table td:last-child { font-weight: 600; color: var(--text-1); }

    .hidden-badge {
        display: inline-block; background: #f1f5f9;
        color: #94a3b8; border: 1px solid #e2e8f0;
        font-size: .75rem; font-weight: 700;
        padding: 2px 10px; border-radius: 99px;
        font-style: italic;
    }
</style>

<div class="info-wrapper">
    <div class="info-card">
        <div class="info-card__icon">🔍</div>
        <h1 class="info-card__title">Here's who referred you</h1>
        <p class="info-card__sub">The referrer controls what information is shared with you.</p>

        <table class="referrer-table">
            <tr>
                <td>Name</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displayName == 'Anonymous'}">
                            <span class="hidden-badge">Anonymous</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displayName}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displayEmail == 'Hidden'}">
                            <span class="hidden-badge">Hidden</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displayEmail}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Mobile</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displayMobile == 'Hidden'}">
                            <span class="hidden-badge">Hidden</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displayMobile}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Telegram</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displayTelegram == 'Hidden'}">
                            <span class="hidden-badge">Hidden</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displayTelegram}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Instagram</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displayInstagram == 'Hidden'}">
                            <span class="hidden-badge">Hidden</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displayInstagram}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
            <tr>
                <td>Snapchat</td>
                <td>
                    <c:choose>
                        <c:when test="${info.displaySnapchat == 'Hidden'}">
                            <span class="hidden-badge">Hidden</span>
                        </c:when>
                        <c:otherwise><c:out value="${info.displaySnapchat}" /></c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </table>

        <a class="btn btn-primary btn-block"
           href="register?ref=<c:out value='${referralCode}'/>"
           style="display:flex;align-items:center;justify-content:center;gap:8px;padding:14px;">
            ✍️ Join Now
            <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                <line x1="5" y1="12" x2="19" y2="12"/><polyline points="12 5 19 12 12 19"/>
            </svg>
        </a>
    </div>
</div>

<%@ include file="footer.jsp" %>