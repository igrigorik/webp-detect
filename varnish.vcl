 backend default {
     .host = "127.0.0.1";
     .port = "8080";
 }

sub webp_detect {
  unset req.http.WebP;

  if (req.http.Accept ~ "image\/webp") {
    set req.http.WebP = "true";
  }
}


sub vcl_recv {
  set req.http.host = "yoursite.com";
  set req.backend = default;

  // detect WebP support
  call webp_detect;

  if (req.request == "GET") {
     return(lookup);
  }

  if (req.request != "GET" && req.request != "HEAD" &&
     req.request != "PUT" && req.request != "POST" &&
     req.request != "TRACE" && req.request != "OPTIONS" &&
     req.request != "DELETE") {

     # Non-RFC2616 or CONNECT which is weird.
     return(pass);
 }

 return(lookup);
}

sub vcl_fetch {
  // no caching, configure your own strategy here
  return(hit_for_pass);
}
