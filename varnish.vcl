 backend default {
     .host = "127.0.0.1";
     .port = "8080";
 }

sub webp_detect {
  unset req.http.WebP;

  if (req.http.User-Agent ~ "(?i)(Android\s|Chrome\/|Opera9.8*Version\/..\.|Opera..\.)" ||
      req.http.Accept ~ "image\/webp") {
    set req.http.WebP = "lossy";
  }

  if (req.http.User-Agent ~ "(?i)(Chrome\/...?\.)") {
    set req.http.WebP = "lossy, lossless";
  }
}

sub webp_blacklist {
  if (req.http.User-Agent ~ "(?i)Chrome\/(.|1.|20|21|22)\.") {
    unset req.http.WebP;
    set req.http.WebP = "lossy";
  }

  if (req.http.User-Agent ~ "(?i)Android\s(0|1|2|3)\." ||
      req.http.User-Agent ~ "(?i)Chrome\/[0-8]\." ||
      req.http.User-Agent ~ "(?i)Chrome\/9\.0\." ||
      // Chrome 14, 15 and 16 had webp rendering bug.
      req.http.User-Agent ~ "(?i)Chrome\/1[4-6]\." ||
      // Clank v<21 had webp endianness bug.
      req.http.User-Agent ~ "(?i)Android\sChrome\/1.\." ||
      req.http.User-Agent ~ "(?i)Android\sChrome\/20\." ||
      req.http.User-Agent ~ "(?i)Opera\/9\.80*Version\/10\." ||
      req.http.User-Agent ~ "(?i)Opera\/9\.80*Version\/11\.0" ||
      req.http.User-Agent ~ "(?i)Opera.10\." ||
      req.http.User-Agent ~ "(?i)Opera.11\."
    ) {
      unset req.http.WebP;
    }
}

sub vcl_recv {
  set req.http.host = "yoursite.com";
  set req.backend = default;

  // detect WebP support
  call webp_detect;
  call webp_blacklist;

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
