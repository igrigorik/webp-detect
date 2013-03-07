// Copyright 2010 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// WebP User-Agent detection rules from:
// https://code.google.com/p/modpagespeed/source/browse/trunk/src/net/instaweb/http/user_agent_matcher.cc#86

// For webp rewriting, we whitelist Android, Chrome and Opera, but blacklist
// older versions of the browsers that are not webp capable.  As other browsers
// roll out webp support we will need to update this list to include them.

const char* kWebpWhitelist[] = {
  "*Android *",
  "*Chrome/*",
  "*Opera/9.80*Version/??.*",
  "*Opera???.*"
};

const char* kWebpBlacklist[] = {
  "*Android 0.*",
  "*Android 1.*",
  "*Android 2.*",
  "*Android 3.*",
  "*Chrome/0.*",
  "*Chrome/1.*",
  "*Chrome/2.*",
  "*Chrome/3.*",
  "*Chrome/4.*",
  "*Chrome/5.*",
  "*Chrome/6.*",
  "*Chrome/7.*",
  "*Chrome/8.*",
  "*Chrome/9.0.*",
  // Chrome 14, 15 and 16 had webp rendering bug.
  "*Chrome/14.*",
  "*Chrome/15.*",
  "*Chrome/16.*",
  // Clank v<21 had webp endianness bug.
  "*Android *Chrome/1?.*",
  "*Android *Chrome/20.*",
  "*Opera/9.80*Version/10.*",
  "*Opera?10.*",
  "*Opera/9.80*Version/11.0*",
  "*Opera?11.0*",
};

const char* kWebpLosslessAlphaWhitelist[] = {
  "*Chrome/??.*",
  "*Chrome/???.*"
};

const char* kWebpLosslessAlphaBlacklist[] = {
  "*Chrome/?.*",
  "*Chrome/1?.*",
  "*Chrome/20.*",
  "*Chrome/21.*",
  "*Chrome/22.*",
};
