# WebP User-Agent detection

A collection of configuration scripts and snippets for detecting WebP support:

- A new request header (`WebP`) is appended to the proxied request
- WebP header value is either "lossy", or "lossy, lossless"

![WebP Detect](http://origin.igvita.com/posts/13/webp-serverside.png)

Based on above, the application server can customize the HTML of the document to provide WebP optimized pages, or fallback to a different image format. Of course, you don't have to use this for just HTML customization: same logic can be adapted to dynamically serve the image assets themselves.


## Getting started

Download or copy the configuration file and run your server. For example:

```
$> nginx -c /path-to/webp-detect/nginx.conf
$> varnishd -a :8081 -T localhost:6082 -F -f varnish.vcl
```

With the above in place, access the page and look at the request header appended by the server - you will see a new `WebP` header sent to your application server if the browser supports WebP.

### Why two values within the header?

Lossless support (with alpha channel) was added in 2012, and older user-agents do not support it. Newer UA's support both. The header allows you to easily determine whether the current UA supports lossless + alpha channel WebP images.

### What about server X?

Please send a pull request!
