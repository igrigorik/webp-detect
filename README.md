# WebP with Accept negotiation

A collection of configuration scripts for serving WebP assets:

- Check if the client advertises "image/webp" in Accept header
- If WebP is supported, check if the local WebP file is on disk, and serve it
- If server is configured as proxy, append a "WebP: true" header and forward to backend
- Append "Vary: Accept" if a WebP asset is served

Above sequence of steps allows transparent negotiation of WebP assets - no need to modify your existing applications. Either pregenerate the WebP files, or serve WebP files dynamically to approriate clients.

## Getting started

Download or copy the configuration file and run your server. For example:

```
$> nginx -c /path-to/webp-detect/nginx.conf
$> varnishd -a :8081 -T localhost:6082 -F -f varnish.vcl
```

With the above in place, access the page and look at the request header appended by the server - you will see a new `WebP` header sent to your application server if the browser supports WebP.

### What about server X?

* See list of included server configurations above.
* Connect middleware (node.js): https://github.com/msemenistyi/connect-image-optimus
* ... please send a pull request!

## Implementation notes

The concept of Accept negotiations is explained in details in
[Deploying WebP via Accept Content Negotiation](http://www.igvita.com/2013/05/01/deploying-webp-via-accept-content-negotiation/).
The current version of a nginx.conf file doesn't use `if` and `rewrite` of the above mentioned
article opting for `map` and `try_files`. For details, please refer to
[Serve files with nginx conditionally](http://www.lazutkin.com/blog/2014/02/23/serve-files-with-nginx-conditionally/).
