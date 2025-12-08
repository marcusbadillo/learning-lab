# Deconstruction of a Web Security Software Botnet Detection via Malicious JavaScript

## Executive Summary

During routine browsing activity, the user was redirected from a sign-up form to a secondary webpage that attempted to load a known malicious JavaScript resource:

Due to business details exposure this is referenced as xxxxxx.com

Web Security application (name withheld for privacy and abstraction) intercepted the request and classified it as malicious, consistent with botnet distribution, malvertising infrastructure, or injection-based compromise.

This document outlines the professional Blue-Team workflow used to safely acquire, deobfuscate, analyze, and document malicious JavaScript artifacts.

---

## Scope of Investigation

- Identify how the malicious JavaScript payload was delivered.
- Safely retrieve the script using multiple controlled techniques.
- Deobfuscate the script and extract Indicators of Compromise (IOCs).
- Determine whether the redirect originated from malvertising, server compromise, or injected content.
- Document findings according to Blue-Team and DFIR standards.

---

## Incident Overview

A user navigated to a sign-up form and was redirected to a webpage that attempted to deliver a malicious JavaScript file. Web Security Software blocked the request, preventing execution of the script.

Suspicious URL:

```text
https://xxxxxx.com/clipper/dom-composer.js
```

Source page (referrer, not same as origin using xxxxxx for example only):

```text
https://www.xxxxxx.com/xxxxxx?submissionGuid=XXXX
```

---

## Immediate Red Flags

1. **Unknown hosting domain** not associated with any common CDNs or legitimate script providers.
2. **Suspicious path (“/clipper”)** commonly appearing in malware ecosystems (clipper malware, botnet droppers, malvertising payloads).
3. **Redirect chains** were present and appeared influenced by user-agent and session context.
4. **Possible script injection** on the referring site, suggesting server compromise or malvertising delivery.

---

## Professional Documentation Workflow

### 1. Acquire the Malicious Script Safely

Always use isolated environments such as:

- Virtual machines (Kali, Ubuntu, Windows Sandbox)
- Cloud sandboxes
- Browser + Burp Suite interception
- `curl` usage only inside non-production environments

Never render or execute suspicious JavaScript in a browser on your host machine, even though for malware research, analysts routinely download malicious JS, HTML, EXE, DLL, and more as inert samples.

#### Why You Cannot Rely on curl Alone

Malicious infrastructure often uses polymorphism, meaning payloads change between requests. Differences may depend on:

- User-agent (Chrome vs Firefox vs curl)
- Operating system
- Referrer
- Cookies or session tokens
- Geolocation
- Execution context (browser-required JS)
- Redirect depth
- Professional Rationale
- params

Because of the client–server architecture and HTTP request/response lifecycle, malicious actors generate unique payloads per visitor to evade static detection and signature-based scanning.

#### Retrieving the Closest Browser-Equivalent Payload

Use curl with spoofed headers to more closely replicate a real browser:

```bash
# NOTE: Replace *** with the actual version numbers from your system's browser.
curl -A "Mozilla/*** (Windows NT 10.0; Win64; x64) AppleWebKit/*** (KHTML, like Gecko) Chrome/*** Safari/***" \
  -H "Referer: https://www.xxxxxx.com/" \
  -L \
  -o dom-composer.js \
  "https://xxxxxx.com/clipper/dom-composer.js"
```

-A sets the user-agent to a real Chrome browser

-H Referer: simulates the page that linked to it

-L follows redirect chains (malvertisers often use 302 redirects)

#### 🧠 BUT — professional analysis requires multiple captures

| Capture Method       | Purpose                                            |
| -------------------- | -------------------------------------------------- |
| Browser + Burp Suite | Exact payload delivered to the browser             |
| Curl (spoofed UA)    | Verifies user-agent–specific variations            |
| Curl (default UA)    | Detects filtering of non-browser clients           |
| Sandbox browser      | Detects behavior-triggered or conditional payloads |

And compare these samples to detect:

***Indicators of Conditional Delivery***

1. Payload switching

2. Fingerprinting logic

3. Hidden secondary requests

4. Time-based or session-based variation

5. Evidence of DOM injection or supply-chain compromise

---

### 2. Deobfuscation Workflow

Pretty-print the JavaScript:

```bash
js-beautify dom-composer.js > clean.js
```

parse for obfuscation patterns and Extracting IOCs (Remote domains, Payload URLs, Redirect chains, IP addresses, Base64 blobs & frags, Suspicious DOM manipulation)

```bash
grep -E "eval|atob|unescape|Function|while\(true\)|document\.write|innerHTML" clean.js

```
