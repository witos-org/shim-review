This repo is for review of requests for signing shim. To create a request for review:

- clone this repo (preferably fork it)
- edit the template below
- add the shim.efi to be signed
- add build logs
- add any additional binaries/certificates/SHA256 hashes that may be needed
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push it to GitHub
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your tag
- approval is ready when the "accepted" label is added to your issue

Note that we really only have experience with using GRUB2 or systemd-boot on Linux, so
asking us to endorse anything else for signing is going to require some convincing on
your part.

As of 20 October 2025, shims sent to Microsoft will be signed with the 2011 and 2023 keys. For each shim you submit, you will receive two copies back, each signed by a different key. Here is the latest information from Microsoft: https://techcommunity.microsoft.com/blog/hardware-dev-center/signing-with-the-new-2023-microsoft-uefi-certificates-what-submitters-need-to-kn/4455787

New signing requirements have also taken effect, and are available here: https://techcommunity.microsoft.com/blog/hardware-dev-center/updated-microsoft-uefi-signing-requirements/1062916 Please note that undergoing this shim review exempts you from yearly security audits, as long as your shim only hands off to open source boot loaders.

Hint: check the [docs](./docs/) directory in this repo for guidance on submission and getting your shim signed.

Here's the template:

*******************************************************************************
### What organization or people are asking to have this signed?
*******************************************************************************
Organization name and website:  
Witine Limited
https://witine.com

*******************************************************************************
### What's the legal data that proves the organization's genuineness?
The reviewers should be able to easily verify, that your organization is a legal entity, to prevent abuse.
Provide the information, which can prove the genuineness with certainty.
*******************************************************************************
Company/tax register entries or equivalent:  
(a link to the organization entry in your jurisdiction's register will do)  

Witine Limited is a limited company registered in England and Wales, with
company registration number 13498267. Our company registration can be viewed at
https://find-and-update.company-information.service.gov.uk/company/13498267

The public details of both your organization and the issuer in the EV certificate used for signing .cab files at Microsoft Hardware Dev Center File Signing Services.  
(**not** the CA certificate embedded in your shim binary)

Example:

```
Issuer: O=MyIssuer, Ltd., CN=MyIssuer EV Code Signing CA
Subject: C=XX, O=MyCompany, Inc., CN=MyCompany, Inc.
```

```
Issuer: C=US, O=DigiCert, Inc., CN=DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021 CA1
Subject: SERIALNUMBER=13498267, C=GB, L=Saffron Walden, O=Witine Limited, CN=Witine Limited
```

*******************************************************************************
### What product or service is this for?
*******************************************************************************
Cleith, a high-performance open-source network operating system.

*******************************************************************************
### What's the justification that this really does need to be signed for the whole world to be able to boot it?
*******************************************************************************
Cleith is a software product and therefore we do not control our users'
systems/hardware.

*******************************************************************************
### Why are you unable to reuse shim from another distro that is already signed?
*******************************************************************************
Because we use a custom-built kernel in order to cherry-pick networking-related
patches not already in the current kernel version. We additionally distribute
device firmware released by the manufacturer and signed by our custom CA, which
has not been incorporated to the upstream release for optimal performance.

*******************************************************************************
### Who is the primary contact for security updates, etc.?
The security contacts need to be verified before the shim can be accepted. For subsequent requests, contact verification is only necessary if the security contacts or their PGP keys have changed since the last successful verification.

An authorized reviewer will initiate contact verification by sending each security contact a PGP-encrypted email containing random words.
You will be asked to post the contents of these mails in your `shim-review` issue to prove ownership of the email addresses and PGP keys.
Please upload the PGP keys to a well-known keyserver like keyserver.ubuntu.com and/or include them in the review as an .asc file, and point to them here.

*******************************************************************************
- Name: Cleith Security Team
- Position: Cleith Security Team
- Email address: security@cleith.net
- PGP key fingerprint: `4DBA270B0B7AEB6B481292696737D81B697FFB51`
- File/keyserver location: available from keyserver.ubuntu.com

*******************************************************************************
### Who is the secondary contact for security updates, etc.?
*******************************************************************************
- Name: Andrew Ying
- Position: Managing Director
- Email address: andrew@witine.com
- PGP key fingerprint: `7EAE8418E5752B0920A41F4F331E75DE62521FF7`
- File/keyserver location: available from keyserver.ubuntu.com

*******************************************************************************
### Were these binaries created from the 16.1 shim release tar?
Please create your shim binaries starting with the 16.1 shim release tar file: https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2

This matches https://github.com/rhboot/shim/releases/tag/16.1 and contains the appropriate gnu-efi source.

Make sure the tarball is correct by verifying your download's checksum
(SHA256, SHA512) with the following ones:

```
46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2
ca5f80e82f3b80b622028f03ef23105c98ee1b6a25f52a59c823080a3202dd4b9962266489296e99f955eb92e36ce13e0b1d57f688350006bba45f2718f159fb  shim-16.1.tar.bz2
```

Make sure that you've verified that your build process uses that file
as a source of truth (excluding external patches) and its checksum
matches. You can also further validate the release by checking the PGP
signature: there's [a detached
signature](https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2.asc)

The release is signed by the maintainer Peter Jones - his master key
has the fingerprint `B00B48BC731AA8840FED9FB0EED266B70F4FEF10` and the
signing sub-key in the signature here has the fingerprint
`02093E0D19DDE0F7DFFBB53C1FD3F540256A1372`. A copy of his public key
is included here for reference:
[pjones.asc](https://github.com/rhboot/shim-review/blob/main/pjones.asc)

Once you're sure that the tarball you are using is correct and
authentic, please confirm this here with a simple *yes*.

A short guide on verifying public keys and signatures should be available in the [docs](./docs/) directory.
*******************************************************************************
Yes.

*******************************************************************************
### URL for a repo that contains the exact code which was built to result in your binary:
Hint: If you attach all the patches and modifications that are being used to your application, you can point to the URL of your application here (*`https://github.com/YOUR_ORGANIZATION/shim-review`*).

You can also point to your custom git servers, where the code is hosted.
*******************************************************************************
https://git.witine.com/cleith/shim/-/tree/cleith/16.1-2_cle1?ref_type=tags

*******************************************************************************
### What patches are being applied and why:
Mention all the external patches and build process modifications, which are used during your building process, that make your shim binary be the exact one that you posted as part of this application.
*******************************************************************************
- `debian/patches/0001-Fix-build-with-binutils-2.46.patch`: cherry-picked from
  upstream to ensure compatibility with binutils 2.46.

*******************************************************************************
### Do you have the NX bit set in your shim? If so, is your entire boot stack NX-compatible and what testing have you done to ensure such compatibility?

See https://techcommunity.microsoft.com/t5/hardware-dev-center/nx-exception-for-shim-community/ba-p/3976522 for more details on the signing of shim without NX bit.
*******************************************************************************
No. We intend to set NX bit in the future as the Debian boot stack becomes
NX-compatible.

*******************************************************************************
### What exact implementation of Secure Boot in GRUB2 do you have? (Either Upstream GRUB2 shim_lock verifier or Downstream RHEL/Fedora/Debian/Canonical-like implementation)
Skip this, if you're not using GRUB2.
*******************************************************************************
We use the downstream Debian implementation.

*******************************************************************************
### Do you have fixes for all the following GRUB2 CVEs applied?
**Skip this, if you're not using GRUB2, otherwise make sure these are present and confirm with _yes_.**

* 2020 July - BootHole
  * Details: https://lists.gnu.org/archive/html/grub-devel/2020-07/msg00034.html
  * CVE-2020-10713
  * CVE-2020-14308
  * CVE-2020-14309
  * CVE-2020-14310
  * CVE-2020-14311
  * CVE-2020-15705
  * CVE-2020-15706
  * CVE-2020-15707
* March 2021
  * Details: https://lists.gnu.org/archive/html/grub-devel/2021-03/msg00007.html
  * CVE-2020-14372
  * CVE-2020-25632
  * CVE-2020-25647
  * CVE-2020-27749
  * CVE-2020-27779
  * CVE-2021-3418 (if you are shipping the shim_lock module)
  * CVE-2021-20225
  * CVE-2021-20233
* June 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-06/msg00035.html, SBAT increase to 2
  * CVE-2021-3695
  * CVE-2021-3696
  * CVE-2021-3697
  * CVE-2022-28733
  * CVE-2022-28734
  * CVE-2022-28735
  * CVE-2022-28736
  * CVE-2022-28737
* November 2022
  * Details: https://lists.gnu.org/archive/html/grub-devel/2022-11/msg00059.html, SBAT increase to 3
  * CVE-2022-2601
  * CVE-2022-3775
* October 2023 - NTFS vulnerabilities
  * Details: https://lists.gnu.org/archive/html/grub-devel/2023-10/msg00028.html, SBAT increase to 4
  * CVE-2023-4693
  * CVE-2023-4692
* February 2025
  * Details: https://lists.gnu.org/archive/html/grub-devel/2025-02/msg00024.html, SBAT increase to 5
  * CVE-2024-45774
  * CVE-2024-45775
  * CVE-2024-45776
  * CVE-2024-45777
  * CVE-2024-45778
  * CVE-2024-45779
  * CVE-2024-45780
  * CVE-2024-45781
  * CVE-2024-45782
  * CVE-2024-45783
  * CVE-2025-0622
  * CVE-2025-0624
  * CVE-2025-0677
  * CVE-2025-0678
  * CVE-2025-0684
  * CVE-2025-0685
  * CVE-2025-0686
  * CVE-2025-0689
  * CVE-2025-0690
  * CVE-2025-1118
  * CVE-2025-1125
*******************************************************************************
Yes, the Debian Trixie port has fixes for all of the above CVEs applied.

*******************************************************************************
### If shim is loading GRUB2 bootloader, and if these fixes have been applied, is the upstream global SBAT generation in your GRUB2 binary set to 5?
Skip this, if you're not using GRUB2, otherwise do you have an entry in your GRUB2 binary similar to:  
`grub,5,Free Software Foundation,grub,GRUB_UPSTREAM_VERSION,https://www.gnu.org/software/grub/`?
*******************************************************************************
Yes.

*******************************************************************************
### Were old shims hashes provided to Microsoft for verification and to be added to future DBX updates?
### Does your new chain of trust disallow booting old GRUB2 builds affected by the CVEs?
If you had no previous signed shim, say so here. Otherwise a simple _yes_ will do.
*******************************************************************************
We have no previous signed shim.

*******************************************************************************
### If your boot chain of trust includes a Linux kernel:
### Is upstream commit [1957a85b0032a81e6482ca4aab883643b8dae06e "efi: Restrict efivar_ssdt_load when the kernel is locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1957a85b0032a81e6482ca4aab883643b8dae06e) applied?
### Is upstream commit [75b0cea7bf307f362057cc778efe89af4c615354 "ACPI: configfs: Disallow loading ACPI tables when locked down"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=75b0cea7bf307f362057cc778efe89af4c615354) applied?
### Is upstream commit [eadb2f47a3ced5c64b23b90fd2a3463f63726066 "lockdown: also lock down previous kgdb use"](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eadb2f47a3ced5c64b23b90fd2a3463f63726066) applied?
Hint: upstream kernels should have all these applied, but if you ship your own heavily-modified older kernel version, that is being maintained separately from upstream, this may not be the case.  
If you are shipping an older kernel, double-check your sources; maybe you do not have all the patches, but ship a configuration, that does not expose the issue(s).
*******************************************************************************
Yes, all three patches are applied.

*******************************************************************************
### How does your signed kernel enforce lockdown when your system runs with Secure Boot enabled?
Hint: If it does not, we are not likely to sign your shim.
*******************************************************************************
Using the existing upstream mechanisms with enhancement from Debian patches.

*******************************************************************************
### Do you build your signed kernel with additional local patches? What do they do?
*******************************************************************************
Yes, we apply networking-related patches.

*******************************************************************************
### Do you use an ephemeral key for signing kernel modules?
### If not, please describe how you ensure that one kernel build does not load modules built for another kernel.
*******************************************************************************
Yes.

*******************************************************************************
### If you use vendor_db functionality of providing multiple certificates and/or hashes please briefly describe your certificate setup.
### If there are allow-listed hashes please provide exact binaries for which hashes are created via file sharing service, available in public with anonymous access for verification.
*******************************************************************************
No.

*******************************************************************************
### If you are re-using the CA certificate from your last shim binary, you will need to add the hashes of the previous GRUB2 binaries exposed to the CVEs mentioned earlier to vendor_dbx in shim. Please describe your strategy.
This ensures that your new shim+GRUB2 can no longer chainload those older GRUB2 binaries with issues.

If this is your first application or you're using a new CA certificate, please say so here.
*******************************************************************************
This is our first application.

*******************************************************************************
### Is the Dockerfile in your repository the recipe for reproducing the building of your shim binary?
A reviewer should always be able to run `docker build .` to get the exact binary you attached in your application.

Hint: Prefer using *frozen* packages for your toolchain, since an update to GCC, binutils, gnu-efi may result in building a shim binary with a different checksum.

If your shim binaries can't be reproduced using the provided Dockerfile, please explain why that's the case, what the differences would be and what build environment (OS and toolchain) is being used to reproduce this build? In this case please write a detailed guide, how to setup this build environment from scratch.
*******************************************************************************
Yes.

*******************************************************************************
### Which files in this repo are the logs for your build?
This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
*******************************************************************************
`build.log`

*******************************************************************************
### What changes were made in the distro's secure boot chain since your SHIM was last signed?
For example, signing new kernel's variants, UKI, systemd-boot, new certs, new CA, etc..

Skip this, if this is your first application for having shim signed.
*******************************************************************************
This is our first application.

*******************************************************************************
### What is the SHA256 hash of your final shim binary?
*******************************************************************************
```
80c80abd5ebf70e3472ba0dcea31cd4d4c0b1479d36e9ea31606354128592673  /shim-review/shimx64.efi
```

*******************************************************************************
### How do you manage and protect the keys used in your shim?
Describe the security strategy that is used for key protection. This can range from using hardware tokens like HSMs or Smartcards, air-gapped vaults, physical safes to other good practices.
*******************************************************************************
The key is stored and protected using the AWS Key Management Service in a FIPS
140-3 Level 3 validated HSM with appropriate access control in place to prevent
unauthorized access.

*******************************************************************************
### Do you use EV certificates as embedded certificates in the shim?
A _yes_ or _no_ will do. There's no penalty for the latter.
*******************************************************************************
No.

*******************************************************************************
### Are you embedding a CA certificate in your shim?
A _yes_ or _no_ will do. There's no penalty for the latter. However,
if _yes_: does that certificate include the X509v3 Basic Constraints
to say that it is a CA? See the [docs](./docs/) for more guidance
about this.
*******************************************************************************
Yes, and yes.

*******************************************************************************
### Do you add a vendor-specific SBAT entry to the SBAT section in each binary that supports SBAT metadata ( GRUB2, fwupd, fwupdate, systemd-boot, systemd-stub, shim + all child shim binaries )?
### Please provide the exact SBAT entries for all binaries you are booting directly through shim.
Hint: The history of SBAT and more information on how it works can be found [here](https://github.com/rhboot/shim/blob/main/SBAT.md). That document is large, so for just some examples check out [SBAT.example.md](https://github.com/rhboot/shim/blob/main/SBAT.example.md)

If you are using a downstream implementation of GRUB2 (e.g. from Fedora or Debian), make sure you have their SBAT entries preserved and that you **append** your own (don't replace theirs) to simplify revocation.

**Remember to post the entries of all the binaries. Apart from your bootloader, you may also be shipping e.g. a firmware updater, which will also have these.**

Hint: run `objcopy --dump-section .sbat=/dev/stdout YOUR_EFI_BINARY` to get these entries. Paste them here. Preferably surround each listing with three backticks (\`\`\`), so they render well.
*******************************************************************************
Shim:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,4,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.cleith,1,Cleith,shim,16.1,mail:security@cleith.net
```

Grub:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,5,Free Software Foundation,grub,2.12,https://www.gnu.org/software/grub/
grub.debian,5,Debian,grub2,2.12-9,https://tracker.debian.org/pkg/grub2
grub.debian14,1,Debian,grub2,2.12-9,https://tracker.debian.org/pkg/grub2
grub.peimage,2,Canonical,grub2,2.12-9,https://salsa.debian.org/grub-team/grub/-/blob/master/debian/patches/secure-boot/efi-use-peimage-shim.patch
grub.cleith,1,Cleith,grub2,2.12-9,mail:security@cleith.net
```

fwupd-efi:
```
sbat,1,UEFI shim,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
fwupd-efi,1,Firmware update daemon,fwupd-efi,1.8,https://github.com/fwupd/fwupd-efi
fwupd-efi.cleith,1,Cleith,fwupd,1:1.8-5+cle1,mail:security@cleith.net
```

*******************************************************************************
### If shim is loading GRUB2 bootloader, which modules are built into your signed GRUB2 image?
Skip this, if you're not using GRUB2.

Hint: this is about those modules that are in the binary itself, not the `.mod` files in your filesystem.
*******************************************************************************
```
all_video boot btrfs cat chain configfile cpuid cryptodisk echo efifwsetup
efinet ext2 fat font gcry_blowfish gcry_camellia gcry_rijndael gcry_rsa
gcry_serpent gcry_sha256 gcry_sha512 gcry_twofish gcry_whirlpool gettext gfxmenu
gfxterm gfxterm_background gzio halt help http iso9660 jpeg keystatus linux
loadenv loopback ls lsefi lsefimmap lsefisystab luks luks2 mdraid09 mdraid1x
memdisk minicmd normal part_apple part_gpt part_msdos password_pbkdf2 peimage
play png probe reboot regexp search search_fs_file search_fs_uuid search_label
serial sleep smbios squash4 test tftp tpm true video xfs
```

*******************************************************************************
### If you are using systemd-boot on arm64 or riscv, is the fix for [unverified Devicetree Blob loading](https://github.com/systemd/systemd/security/advisories/GHSA-6m6p-rjcq-334c) included?
*******************************************************************************
We do not use `systemd-boot`.

*******************************************************************************
### What is the origin and full version number of your bootloader (GRUB2 or systemd-boot or other)?
*******************************************************************************
We use the GRUB2 bootloader, based on the Debian Trixie GRUB2 bootloader.

*******************************************************************************
### If your shim launches any other components apart from your bootloader, please provide further details on what is launched.
Hint: The most common case here will be a firmware updater like fwupd.
*******************************************************************************
Our shim additionally launches fwupd, which is in turn based on the Debian fork
of fwupd.

*******************************************************************************
### If your GRUB2 or systemd-boot launches any other binaries that are not the Linux kernel in SecureBoot mode, please provide further details on what is launched and how it enforces Secureboot lockdown.
Skip this, if you're not using GRUB2 or systemd-boot.
*******************************************************************************
GRUB2 does not launch any other binaries.

*******************************************************************************
### How do the launched components prevent execution of unauthenticated code?
Summarize in one or two sentences, how your secure bootchain works on higher level.
*******************************************************************************
GRUB2 verifies the kernel signature via shim. fwupd-efi doesn't load any other
components.

*******************************************************************************
### Does your shim load any loaders that support loading unsigned kernels (e.g. certain GRUB2 configurations)?
*******************************************************************************
No.

*******************************************************************************
### What kernel are you using? Which patches and configuration does it include to enforce Secure Boot?
*******************************************************************************
We use the Linux 7.0 kernel with patches from the Debian and Ubuntu. The
lockdown patches have been applied to enforce Secure Boot.

*******************************************************************************
### What contributions have you made to help us review the applications of other applicants?
The reviewing process is meant to be a peer-review effort and the best way to have your application reviewed faster is to help with reviewing others. We are in most cases volunteers working on this venue in our free time, rather than being employed and paid to review the applications during our business hours. 

A reasonable timeframe of waiting for a review can reach 2-3 months. Helping us is the best way to shorten this period. The more help we get, the faster and the smoother things will go.

For newcomers, the applications labeled as [*easy to review*](https://github.com/rhboot/shim-review/issues?q=is%3Aopen+is%3Aissue+label%3A%22easy+to+review%22) are recommended to start the contribution process.
*******************************************************************************
We have not participated in reviews at this time but intend to contribute
moving forward.

*******************************************************************************
### Add any additional information you think we may need to validate this shim signing application.
*******************************************************************************
None.
