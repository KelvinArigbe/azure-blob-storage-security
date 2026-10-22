# Evidence review

14 screenshots reviewed. Email/tenant details, object IDs, request IDs, browser account controls and personal shell prompts were masked or cropped where present. Masks replace pixels; PNGs are re-encoded without original metadata. Generic lab resource names remain for traceability. No credentials were observed. Original files are unchanged and excluded.

| File | Evidence |
|---|---|
| `01-storage-lab-resource-group.png` | Resource-group list: storage lab in East US. |
| `03-private-container.png` | Private container with account-level anonymous-access warning. |
| `04-anonymous-access-blocked-baseline.png` | Initial PublicAccessNotPermitted response. |
| `05-container-anonymous-blob-access.png` | Access-level change succeeded; selected Blob level is confirmed by the lab session and screenshot 12, not this toast alone. |
| `06-anonymous-read-succeeded.png` | Dummy content shown in a browser; anonymous test confirmed in session. |
| `07-account-anonymous-access-disabled.png` | Anonymous access disabled; Shared Key still enabled at this intermediate stage. |
| `08-anonymous-read-blocked-after.png` | PublicAccessNotPermitted after remediation. |
| `09-blob-data-reader-assignment.png` | Storage Blob Data Reader assignment; Reader was added later and confirmed in session. |
| `11-authorised-blob-download.png` | Entra user authentication and selected blob; download confirmed by participant. |
| `12-data-reader-upload-blocked.png` | Submitted upload failed with a permission error; stronger evidence than the earlier report of a disabled button. |
| `13-storage-security-configuration.png` | Final anonymous, Shared Key, Entra default, HTTPS and TLS settings. |
| `14-entra-download-after-hardening.png` | Entra user authentication and selected blob after hardening; download confirmed by participant. |
| `15-cli-security-configuration.png` | Stored configuration: False / False / True / True / TLS1_2. |
| `16-storage-audit-results.png` | Final saved-script execution with five PASS results; earlier save errors cropped out. |
