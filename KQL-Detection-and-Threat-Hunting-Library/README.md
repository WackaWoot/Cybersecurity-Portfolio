# KQL Detection & Threat Hunting Library

> **Environment:** Microsoft Defender XDR · Microsoft Sentinel
> **Purpose:** Threat Hunting · Detection Validation · Incident Investigation · Analyst Reference
> **Query Count:** 38 queries across 8 threat categories
> **Audience:** SOC Analysts · Detection Engineers · Threat Hunters

---

## Overview

This library contains a collection of Kusto Query Language (KQL) queries developed for operational use within Microsoft Defender XDR and Microsoft Sentinel. All queries were built with reusability and shared use in mind — each includes inline comments explaining the detection rationale, expected output, and investigative context so any analyst can run, interpret, and adapt them without additional guidance.

Queries span threat hunting, detection validation, incident investigation, IOC enrichment, and environmental awareness use cases. The library is actively maintained and expanded as new threats, CVEs, named threat actor campaigns, and operational hunting requirements emerge.

**Design philosophy:** Every query in this library is written to answer a specific investigative question as precisely and efficiently as possible. The goal is not alert volume but signal clarity — minimizing false positive surface area while maximizing investigative utility across diverse threat scenarios.

> Note: Several queries in this library are informed by production SOC experience and real threat hunting campaigns including named APT activity. All organizationally sensitive context has been removed in compliance with applicable regulatory and operational requirements.

---

## Query Index

### Identity & Authentication

Queries targeting account compromise, unauthorized access, credential-based attacks, and authentication anomalies across Entra ID and M365.

| Query | Use Case |
|---|---|
| Advanced Combined Password Reset Check (EntraID) | Multi-signal password reset investigation combining self-service, admin-initiated, and forced reset events for account takeover detection |
| Entra ID Password Reset Check | Targeted Entra ID password reset event investigation for credential compromise and insider threat scenarios |
| Unusual Sign-ins | Anomalous authentication detection including atypical locations, devices, and behavioral deviations |
| Cross Enterprise Network User Sign-in | Identifies user authentication activity spanning multiple network segments or enterprise boundaries |
| Logon Activity for a Given User Device | Full logon timeline reconstruction for a specified user and device combination for incident scoping |
| Search Infected Account Device Activity | Comprehensive activity reconstruction for accounts or devices flagged as potentially compromised |

---

### Email & Phishing Investigation

Queries for investigating suspicious email activity, phishing delivery, mail rule manipulation, and automation-based threats.

| Query | Use Case |
|---|---|
| Email Search Within Date-Time Range | Scoped email investigation across sender, recipient, subject, and attachment metadata within a defined timeframe |
| Automation Check for Emails | Identifies email activity consistent with automated sending, forwarding rules, or programmatic mail manipulation |
| Outlook Email Rule Updates | Detects creation or modification of Outlook mail rules, a common persistence and exfiltration technique |

---

### Endpoint & Process Behavior

Queries targeting suspicious process execution, unauthorized software, script-based attacks, scheduled task abuse, and endpoint anomaly detection.

| Query | Use Case |
|---|---|
| Adobe Processes | Monitors Adobe application process chains for anomalous child process spawning consistent with exploit or malicious document execution |
| O365 Spawning Processes | Detects Office 365 applications spawning unusual child processes, a primary indicator of macro-based malware and phishing payload delivery |
| Office to PowerShell Child Processes with Suspicious Switches | Identifies Office applications spawning PowerShell with suspicious command-line switches consistent with living-off-the-land attacks |
| Process Injection | Detects process injection indicators across memory allocation, handle duplication, and cross-process write activity |
| Scheduled Task Data Detection | Identifies scheduled task creation and modification events for persistence mechanism detection |
| Scheduled Tasks Spawn from a File | Correlates scheduled task execution to originating file for malware staging and persistence investigation |
| Suspicious File-to-Process Execution within Jenkins Automation | Detects anomalous file-to-process execution chains within Jenkins automation infrastructure, targeting CI/CD pipeline compromise scenarios |
| EXE File Name Hunt | Targeted executable filename search across endpoint telemetry for IOC validation and malware identification |
| Simple Filename Search | Broad filename search across device file events for rapid artifact location during active investigations |
| User Downloaded Executables | Identifies user-initiated executable downloads for investigation of potentially unwanted software, shadow IT, or malware staging |
| USB Hunting | Detects USB device connection and file transfer activity for data exfiltration and removable media policy investigation |

---

### Network & Traffic Analysis

Queries targeting suspicious network behavior, unusual traffic patterns, lateral movement indicators, and command-and-control communication.

| Query | Use Case |
|---|---|
| Port Traffic Search | Investigates traffic across specified ports for anomalous communication, unauthorized service exposure, or lateral movement |
| SMB Traffic Search & Correlation | Correlates SMB traffic events for lateral movement, credential relay, and network share enumeration detection |
| Non-Top Level Domain Traffic | Identifies traffic to non-standard TLDs as an indicator of C2 infrastructure, domain generation algorithm activity, or phishing domains |
| Top 15 Non-Standard Domain Extensions | Surfaces the highest-volume non-standard domain extension traffic for environmental baselining and anomaly identification |
| Offsite Connections to URL | Detects outbound connections to specified external URLs for IOC validation and exfiltration investigation |
| Imperva Abnormal Traffic Search | Investigates anomalous traffic patterns surfaced within Imperva WAF telemetry for web-based attack identification |

---

### Threat Intelligence & IOC Validation

Queries for operationalizing threat intelligence signals against live environmental telemetry across multiple indicator types.

| Query | Use Case |
|---|---|
| Hash Value Check for CommonSecurityLog and DeviceFileEvents (XDR) | Cross-source hash validation across Sentinel CommonSecurityLog and Defender XDR DeviceFileEvents for malware presence confirmation |
| IP Address Search (and Bulk Search) | Single and bulk IP address investigation across network and authentication telemetry for IOC sweeping |
| IoC Search for URL, Domain and Subdomain | Multi-level IOC matching across URLs, apex domains, and subdomains for comprehensive indicator coverage |
| IoC from Threat Intel Indicators STIX/TAXII Feed | Correlates environmental telemetry directly against indicators ingested from STIX/TAXII threat intelligence feeds for automated IOC operationalization |
| Specific Device & Hash Combination Presence | Validates the co-presence of a specific device and file hash for targeted malware confirmation on a known asset |
| Incident History Based on IP Entity (Sentinel and Defender XDR) | Reconstructs full incident history associated with a specific IP entity across both Sentinel and Defender XDR for cross-platform investigation |

---

### Data Exfiltration & Persistence

Queries targeting data staging, unauthorized transfer activity, and persistence mechanism detection.

| Query | Use Case |
|---|---|
| Environment Data Exfiltration Check | Broad environmental sweep for data exfiltration indicators across network, endpoint, and cloud telemetry |
| OAuth App Search | Identifies OAuth application registrations and permission grants for detection of consent phishing and unauthorized application access |

---

### CVE & Named Threat Actor Hunts

Queries developed in direct response to published CVEs and named threat actor campaigns, built from intelligence signals, vendor advisories, and published TTP documentation.

| Query | Use Case |
|---|---|
| CVE-2025-14372 | Targeted behavioral hunt for indicators of exploitation activity associated with CVE-2025-14372 |
| Devices Affected by a Specific CVE | Flexible CVE-to-asset mapping query for rapid identification of vulnerable devices across the environment |
| Brickstorm Threat Hunt | Behavioral hunt targeting BRICKSTORM backdoor TTPs observed in campaigns targeting European enterprise organizations, built from published threat actor TTP documentation |

> Additional threat hunts have been conducted against named APT activity including MuddyWater and others. Not all operational hunts are published in this repository.

---

### Environmental Visibility & Baselining

Queries for maintaining environmental awareness, asset inventory, and operational baseline data.

| Query | Use Case |
|---|---|
| Environment Statistics | Broad environmental telemetry summary for baselining normal activity patterns and supporting anomaly detection calibration |

---

## MITRE ATT&CK Coverage

| Tactic | Covered By |
|---|---|
| Initial Access | Email Search, IoC URL/Domain Search, Unusual Sign-ins, OAuth App Search |
| Execution | O365 Spawning Processes, Office to PowerShell Child Processes, Adobe Processes, Scheduled Tasks |
| Persistence | Scheduled Task Detection, Outlook Email Rule Updates, OAuth App Search, Entra ID Password Reset |
| Defense Evasion | Process Injection, Hash Value Check, Simple Filename Search |
| Credential Access | Entra ID Password Reset, Advanced Password Reset Check, Unusual Sign-ins |
| Discovery | Environment Statistics, Port Traffic Search, IP Address Search |
| Lateral Movement | SMB Traffic Search, Cross Enterprise Sign-in, Logon Activity |
| Collection | USB Hunting, Environment Data Exfiltration Check |
| Command & Control | Non-Standard TLD Traffic, Offsite Connections, IoC STIX/TAXII Feed, Imperva Traffic Search |
| Exfiltration | Environment Data Exfiltration Check, USB Hunting, Offsite Connections |

---

## Usage Notes

**Compatibility:** All queries are written for Microsoft Defender XDR Advanced Hunting and Microsoft Sentinel Log Analytics workspaces. Table availability may vary depending on your connector and data source configuration.

**Inline comments:** Each query file contains inline comments explaining detection logic, investigative intent, and result interpretation guidance. Review comments before modifying query logic to avoid degrading detection fidelity.

**Time range parameters:** Adjust lookback windows based on investigative scope. Behavioral and rare-event hunts benefit from extended windows of 14 to 30 days. High-volume IOC sweeps should be scoped narrowly to manage query performance.

**Environment-specific variables:** Queries referencing IP ranges, trusted domains, or organizational naming conventions are marked in inline comments and should be updated to reflect your environment before operational use.

**Bulk search queries:** IP Address Search and Hash Value Check include bulk search variants designed for high-volume IOC sweeping during active threat response. Usage notes are included inline.

---

## Related Projects

- [Threat Intelligence & OSINT Pipeline](../Threat-Intelligence-OSINT-Pipeline/) — The intelligence pipeline that drives many of the IOC and TTP-based hunts in this library
- [SIEM Exercises](../SIEM%20Exercises/) — Broader SIEM engineering and detection rule development work
- [SOC Defensive Security Project](../SOC%20Defensive%20Security%20Project/) — SOC operational context these queries support

---

*This library is actively maintained. Queries are added and refined as new threats, CVEs, and operational hunting requirements emerge. All production-derived content is sanitized in compliance with applicable organizational and regulatory requirements.*
