# Guide to add SSH key to Yubikey

This guide is far too simple but it took my quite a good time to achieve what i want

## Goal

To create a ssh key pair and store it on yubikey

### Assumptions

- Yubikey is already prepared and it has FIDO keyset. If FIDO key is not set, you will get errors.How to set this key, i will explain shortly in this document.
- Yubikey manager is installed
- All libraries which are required for touch setup are also installed

### Preparation

You need yubikey manager. This is not installed by default.

 Step:01 Create ssh key pair

  ssh-keygen -t ecdsa-sk -O resident

 my recommendation, do not put a paraphrase to ssh key. This double protection is not required

with this step you are ready to use this key on this computer. e.g. copy the pub key from ~/.ssh/keyname.pub location and copy it in github
now, you push or pull changes from github, you just need to press touch on yubikey

But to use this key on another computer, you will need to execute the following commands
  cd ~/.ssh
  ssh-keygen -K (it is capital K)
  mv id_ecdsa_sk_rk ~/.ssh/id_ecdsa_sk 

### Reference

- <https://www.yubico.com/blog/github-now-supports-ssh-security-keys/>

