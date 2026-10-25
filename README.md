# PonteDom Mobile — Demo 1.0

Mobile-first interactive web prototype for [PonteDom](https://pontedom.pl/), inspired by the Mój Pingwinek demo.

## Features
- Responsive mobile app-like interface and bottom navigation
- Polish, English and Italian interface
- Search criteria and locally saved searches (browser localStorage)
- Shortcuts to the live PonteDom website
- Contact form that prepares an email in the visitor's mail app (the recipient address must be verified before production use)

## Important limitations
- This demo **does not fetch live listing records**: no property feed/API has been confirmed. Search opens the live website rather than applying the demo criteria to its listings.
- Saved searches stay on the device/browser only.
- No account login, listing synchronization, native Android APK, or backend messaging.
- Contact recipient is a placeholder pending confirmation.
- This project does not modify pontedom.pl or the earlier pontedom-app repository.

## GitHub Pages
Repository **Settings → Pages → Build and deployment → Deploy from a branch → main → /(root) → Save**.

Expected URL once Pages is enabled: https://thebestjob.github.io/app-pontedom/

## Next steps
Confirm a reliable property data endpoint, map the listing schema (id, title, type, location, price, photos, geo coordinates), then implement actual search, favorites and detail pages. Confirm the inquiry endpoint before accepting real messages.
