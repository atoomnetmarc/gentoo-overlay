# Hi!

These are my personal Gentoo ebuilds overlay.

Use with caution, however feel free to use.

Create `/etc/portage/repos.conf/atoomnetmarc.conf`:
```ini
[atoomnetmarc]
location = /var/db/repos/atoomnetmarc
sync-type = git
sync-uri = https://github.com/atoomnetmarc/gentoo-overlay
priority = 100
```

Then:
```bash
emerge --sync atoomnetmarc
```

# License

Distributed under the terms of the GNU General Public License v2

See also https://gitweb.gentoo.org/repo/gentoo.git/tree/header.txt
