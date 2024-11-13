# waf-xss
# AWS WAF and CKEditor XSS Protection Solution

## Overview

This repository provides a solution to prevent AWS WAF from blocking legitimate HTML content submitted via CKEditor, while maintaining protection against Cross-Site Scripting (XSS) attacks.

## Problem Statement

- Users submitting content through CKEditor encounter 403 errors.
- AWS WAF's `CrossSiteScripting_BODY` rule blocks legitimate HTML content.

## Solution Components

1. **AWS WAF Configuration:**
   - Exclude the `CrossSiteScripting_BODY` rule from the AWS Managed Rules.
2. **Server-Side Input Sanitization:**
   - Implement a sanitization library to clean user-submitted HTML content.
3. **CKEditor Configuration:**
   - Restrict allowed content to safe HTML tags and attributes.
4. **Content Security Policy (CSP):**
   - Add CSP headers to the application to prevent unauthorized script execution.

## Implementation Details

### 1. AWS WAF Configuration

- **File:** `aws_waf.tf`
- **Description:** Terraform script to create a Web ACL that excludes the problematic rule and associates it with the API Gateway.

#### Deployment Steps

1. Initialize and Deploy Terraform:

   ```bash
   terraform init

   terraform plan

   terraform apply --auto-approve

2. Server-Side Input Sanitization
Action Required: Implement a sanitization library in your backend code.
Examples:
Node.js: Use DOMPurify.
Python: Use Bleach.
Java: Use OWASP Java HTML Sanitizer.
3. CKEditor Configuration
File: Update your CKEditor initialization script.

Example Configuration:

CKEDITOR.replace('editor', {
  allowedContent: 'p h1 h2 strong em; a[!href]; img[!src,alt,width,height]; table tr th td tbody thead tfoot; span{*}(*);' // Adjust as needed
});
Description: Restricts users to a safe subset of HTML tags and attributes.

4. Content Security Policy (CSP)
Action Required: Add CSP headers to your application's HTTP responses.

Example Header:

Content-Security-Policy: default-src 'self'; script-src 'self'; object-src 'none';
Description: Prevents execution of unauthorized scripts.

### Testing
Functional Testing
Submit various HTML content through CKEditor to ensure it's accepted and rendered correctly.
Verify that legitimate content is no longer blocked by AWS WAF.

### Security Testing
Attempt to submit malicious scripts to confirm they're sanitized and do not execute.
Check AWS WAF logs to ensure no harmful requests are passing through.

### Monitoring and Maintenance
AWS WAF Logs: Monitor for any unusual activity or blocked requests.
Sanitization Library Updates: Keep your sanitization library up to date.
CSP Adjustments: Modify CSP headers if you add new resources or scripts.

## Conclusion
By adjusting the AWS WAF configuration and implementing proper sanitization and content policies, you can allow users to submit HTML content safely without encountering blocking issues.


