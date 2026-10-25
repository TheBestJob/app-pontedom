# PonteDom Mobile — Website-based demo

This project is a mobile-adapted copy of the user-supplied PonteDom website source, not a separate property catalogue.

## Source and live integrations
- Original PonteDom HTML, styles, layout and translations (PL/EN/IT)
- Leaflet/OpenStreetMap property map
- Listing data loaded by the original code from `https://adriatica-backend.onrender.com/api/listings`
- Existing listing filters, cards/list/large display modes, property details and gallery
- Original Formspree endpoints for property inquiries and home-finding forms
- Extra five-button mobile navigation (Home, Listings, Map, Find a Home, About)

## Hosting
GitHub Pages: Settings → Pages → Deploy from a branch → main / (root).
Expected URL: https://thebestjob.github.io/app-pontedom/

## Important
- This is a separate deployment; it does not modify the live pontedom.pl website.
- Render API must permit cross-origin requests from the GitHub Pages origin. If CORS blocks requests, the app cannot show listings until the backend is configured.
- Availability of the API and submissions have not been end-to-end verified.
- Test all languages, list/card modes, property galleries, map markers and forms on a real phone.
- Avoid replacing the original API or Formspree endpoints without testing.
