# Azure Blob Storage Security Lab

Kelvin Arigbe | 22 October 2026

Test anonymous blob exposure, remediate it, and preserve authorised read access through Microsoft Entra ID.

## Environment

- Resource group: `rg-storage-security-lab` (East US in screenshot 01).
- Storage account: `stseclab7k92m46`.
- Container: `lab-documents`; dummy file: `lab-document.txt` (85 bytes).
- Test user: Lab Analyst.
- Access: Reader for portal navigation; Storage Blob Data Reader for blob reads, both at storage-account scope.

## Results

| Test | Observed result |
|---|---|
| Initial private baseline | Blocked: PublicAccessNotPermitted |
| Account permits anonymous access + Blob container | Anonymous read succeeded |
| Account anonymous access disabled; container remains Blob | Blocked: PublicAccessNotPermitted |
| Reader + Storage Blob Data Reader | Authorised download succeeded |
| Attempted upload of write-test.txt | Permission error displayed |
| Entra download after Shared Key disabled | Succeeded |
| CLI configuration and saved audit script | Five checks passed |

## Changes

1. Created a private container and uploaded dummy text.
2. Confirmed anonymous access returned `PublicAccessNotPermitted`.
3. Enabled anonymous access at account level and Blob access on the container; verified anonymous reading.
4. Disabled account-level anonymous access while retaining the container Blob setting; verified reading was blocked again.
5. Assigned Storage Blob Data Reader and Reader to the analyst at storage-account scope.
6. Verified download using Microsoft Entra user authentication; attempted upload failed with a permission error.
7. Disabled Shared Key access and enabled the portal's Entra default. Entra download still worked.
8. Checked HTTPS and TLS settings with CLI, then ran a saved PowerShell audit script.

## Final configuration

| Property | Verified value |
|---|---|
| allowBlobPublicAccess | false |
| allowSharedKeyAccess | false |
| defaultToOAuthAuthentication | true |
| enableHttpsTrafficOnly | true |
| minimumTlsVersion | TLS1_2 |

Account-level anonymous denial overrides a public container setting. Entra default selects the portal authentication method; disabling Shared Key is the key-access enforcement control.

## Audit script

Run from authenticated Cloud Shell PowerShell or a PowerShell session with Azure CLI installed:

```powershell
./scripts/audit-storage.ps1
```

For a different account:

```powershell
./scripts/audit-storage.ps1 -ResourceGroup YOUR_RESOURCE_GROUP -StorageAccount YOUR_STORAGE_ACCOUNT
```

The script reads account configuration and prints PASS or REVIEW for five values. It changes no Azure settings and exports no account data. The `.ps1` was reconstructed from the exact script provided during the lab; the uploaded screenshot confirms successful execution of the participant's saved version. No script file was attached.

## Evidence

Publication copies are in `evidence/`; captions and privacy treatment are in `EVIDENCE.md`. Missing screenshot numbers were retained; no evidence was fabricated. No CSV, keys, SAS tokens, raw JSON exports or original screenshots are included.

## Scope limits

- Shared Key denial, HTTPS-only and minimum TLS were configuration checks; direct Shared Key, HTTP and older-TLS request tests were not performed.
- Download completion was confirmed in the session; screenshots 11 and 14 show the Entra portal context and selected blob.
- Public networking was used for browser tests. Private endpoints and firewall restrictions were not implemented or validated.
- Container remains configured as Blob; account-level anonymous access is disabled. Changing it to Private would add defense in depth but was not recorded as completed.
- Logging coverage, retention, encryption configuration and policy enforcement were not assessed. The visible `$logs` container alone does not establish logging coverage.
- A PASS means the checked property matches the lab target, not complete storage security or compliance. The script checks TLS1_2 exactly; another value requires review.


## References

- [Anonymous blob access](https://learn.microsoft.com/en-us/azure/storage/blobs/anonymous-read-access-configure)
- [Prevent Shared Key access](https://learn.microsoft.com/en-us/azure/storage/common/shared-key-authorization-prevent)
- [Entra access in the portal](https://learn.microsoft.com/en-us/azure/storage/blobs/authorize-data-operations-portal)
