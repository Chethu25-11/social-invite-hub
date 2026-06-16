<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${pageTitle} – Social Invite Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --brand:        #4F46E5;
            --brand-dark:   #3730A3;
            --brand-light:  #EEF2FF;
            --brand-mid:    #6366F1;
            --surface:      #ffffff;
            --bg:           #F8F9FC;
            --border:       #E4E7EC;
            --text-1:       #101828;
            --text-2:       #344054;
            --text-3:       #667085;
            --success:      #027A48;
            --success-bg:   #ECFDF3;
            --success-bd:   #ABEFC6;
            --danger:       #B42318;
            --danger-bg:    #FEF3F2;
            --danger-bd:    #FECDCA;
            --radius-sm:    6px;
            --radius-md:    10px;
            --radius-lg:    14px;
            --shadow-sm:    0 1px 3px rgba(16,24,40,.08), 0 1px 2px rgba(16,24,40,.06);
            --shadow-md:    0 4px 8px -2px rgba(16,24,40,.10), 0 2px 4px -2px rgba(16,24,40,.06);
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: var(--bg);
            color: var(--text-1);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            -webkit-font-smoothing: antialiased;
        }

        /* ── HEADER ── */
        .site-header {
            background: var(--surface);
            border-bottom: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .site-header__inner {
            max-width: 1120px;
            margin: 0 auto;
            padding: 0 28px;
            height: 62px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }
        .site-header__brand-mark {
            width: 32px;
            height: 32px;
            background: var(--brand);
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .site-header__brand-mark svg {
            width: 18px;
            height: 18px;
            fill: none;
            stroke: #fff;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
        }
        .site-header__brand-name {
            font-weight: 700;
            font-size: 1rem;
            color: var(--text-1);
            letter-spacing: -0.01em;
        }
        .site-header__nav {
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .site-header__nav a {
            padding: 7px 14px;
            border-radius: var(--radius-sm);
            font-size: .875rem;
            font-weight: 500;
            text-decoration: none;
            color: var(--text-2);
            transition: background .15s, color .15s;
        }
        .site-header__nav a:hover { background: var(--brand-light); color: var(--brand); }
        .site-header__nav a.nav-cta {
            background: var(--brand);
            color: #fff;
            font-weight: 600;
            margin-left: 4px;
        }
        .site-header__nav a.nav-cta:hover { background: var(--brand-dark); }
        .site-header__nav a.active { color: var(--brand); font-weight: 600; }

        /* ── MAIN ── */
        .site-main { flex: 1; }

        /* ── FOOTER ── */
        .site-footer {
            background: var(--surface);
            border-top: 1px solid var(--border);
            padding: 22px 28px;
        }
        .site-footer__inner {
            max-width: 1120px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 12px;
        }
        .site-footer__brand {
            font-weight: 700;
            color: var(--text-1);
            font-size: .875rem;
        }
        .site-footer__copy {
            font-size: .8rem;
            color: var(--text-3);
        }
        .site-footer__links {
            display: flex;
            gap: 20px;
        }
        .site-footer__links a {
            font-size: .8rem;
            color: var(--text-3);
            text-decoration: none;
            transition: color .15s;
        }
        .site-footer__links a:hover { color: var(--brand); }

        /* ── FORM UTILITIES ── */
        .form-group { margin-bottom: 16px; }
        .form-label {
            display: block;
            font-size: .8rem;
            font-weight: 600;
            color: var(--text-2);
            margin-bottom: 5px;
        }
        .form-control {
            width: 100%;
            padding: 10px 13px;
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            font-size: .9rem;
            font-family: inherit;
            color: var(--text-1);
            background: var(--surface);
            outline: none;
            transition: border-color .2s, box-shadow .2s;
        }
        .form-control::placeholder { color: var(--text-3); }
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 3px rgba(79,70,229,.12);
        }
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 11px 22px;
            border: none;
            border-radius: var(--radius-sm);
            font-size: .9rem;
            font-family: inherit;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: background .2s, transform .1s, box-shadow .2s;
        }
        .btn:active { transform: scale(.98); }
        .btn-primary {
            background: var(--brand);
            color: #fff;
            box-shadow: 0 1px 2px rgba(16,24,40,.05);
        }
        .btn-primary:hover { background: var(--brand-dark); box-shadow: var(--shadow-md); }
        .btn-block { width: 100%; }
        .alert {
            padding: 12px 14px;
            border-radius: var(--radius-sm);
            font-size: .875rem;
            margin-bottom: 16px;
            font-weight: 500;
            display: flex;
            align-items: flex-start;
            gap: 8px;
        }
        .alert-danger  { background: var(--danger-bg);  color: var(--danger);  border: 1px solid var(--danger-bd); }
        .alert-success { background: var(--success-bg); color: var(--success); border: 1px solid var(--success-bd); }
    </style>
</head>
<body>

<header class="site-header">
    <div class="site-header__inner">
        <a class="site-header__brand" href="/">
            <div class="site-header__brand-mark">
                <svg viewBox="0 0 24 24"><path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5"/></svg>
            </div>
            <span class="site-header__brand-name">Social Invite Hub</span>
        </a>
        <nav class="site-header__nav">
            <c:choose>
                <c:when test="${not empty sessionUser}">
                    <a href="dashboard" class="${currentPage == 'dashboard' ? 'active' : ''}">Dashboard</a>
                    <a href="logout" class="nav-cta">Sign Out</a>
                </c:when>
                <c:otherwise>
                    <a href="/" class="${currentPage == 'login' ? 'active' : ''}">Sign In</a>
                    <a href="register" class="nav-cta ${currentPage == 'register' ? 'active' : ''}">Get Started</a>
                </c:otherwise>
            </c:choose>
        </nav>
    </div>
</header>

<main class="site-main">