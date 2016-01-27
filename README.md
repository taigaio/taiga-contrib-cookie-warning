Taiga Contrib Cookie Warning
============================

![Kaleidos Project](http://kaleidos.net/static/img/badge.png "Kaleidos Project")
[![Managed with Taiga.io](https://taiga.io/media/support/attachments/article-22/banner-gh.png)](https://taiga.io "Managed with Taiga.io")

The Taiga plugin to show the cookie warning message 'C is For Cookie'.

Installation
------------

### Taiga Front

Download in your `dist/plugins/` directory of Taiga front the `taiga-contrib-cookie-warning` compiled code (you need subversion in your system):

```bash
  cd dist/
  mkdir -p plugins
  cd plugins
  svn export "https://github.com/taigaio/taiga-contrib-cookie-warning/branches/stable/dist"  "cookie-warning"
```

Include in your dist/conf.json in privacyPolicyUrl the url to the information of your Privacy Policy and in the contribPlugins list the value `"/plugins/cookie-warning/cookie-warning.json"`:

```json
...
    "privacyPolicyUrl": "http://example.com/privacy-policy.html"
    "contribPlugins": [
        (...)
        "/plugins/cookie-warning/cookie-warning.json"
    ]
...
```
