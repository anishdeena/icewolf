module AppConstants
  #App
  
  PAGINATION_LIMIT = 20
  
  #Category
  SUPER_CATEGORY_PARENT_CATEGORY_ID = -1
  
  #Session managment
  TOKEN_EXPIRY_IN_HOURS = 24
  AUTH_TOKEN_HEADER_NAME = "icewolf-auth-token"
  
  #Location
  LOCATION_ANYLOCATION = -1
  LOCATION_ANYLOCATION_NAME = "Any Location"
  
  #Business 
  BUSINESS_PAGINATION_TYPE = "pagination_type"
  BUSINESS_PAGINATION_OFFSET = "pagination_offset"
  BUSINESS_PAGINATION_LOCATION = "pagination_location"
  BUSINESS_SEARCH_RESULTS = "collections"
  BUSINESS_PAGINATION_TYPE_FRILP = 1
  BUSINESS_PAGINATION_TYPE_JUSTDIAL = 2
  
  #Email
  EMAIL_INVITE_SUBJECT = "Registration"
  EMAIL_REQUEST_SUBJECT = "Your friend seeks recommendation"
  EMAIL_RESPONSE_SUBJECT = "Got a Recommendation"
  EMAIL_COMMUNITY_REQUEST = "Verify joining community"
  EMAIL_FROM = "\"Frilp Operator\"<operator@frilp.com>"
  EMAIL_DOMAIN = "http://www.beta.frilp.com/"
  EMAIL_INVITE_LINK = EMAIL_DOMAIN+"#sync/"
  EMAIL_USER_PROFILE_LINK = EMAIL_DOMAIN+"#userprofile/"
  EMAIL_BUSINESS_PROFILE_LINK = EMAIL_DOMAIN+"#businessprofile/"
  EMAIL_REQUEST_LINK = EMAIL_DOMAIN+"#external/accessrequest/"
  EMAIL_RESPONSE_LINK = EMAIL_DOMAIN+"#external/accessresponse/"
  EMAIL_COMMUNITY_REQUEST_LINK = EMAIL_DOMAIN+"#communityrequest/"
  EMAIL_EMAIL_INVITE_REQUEST_LINK = EMAIL_DOMAIN+"#sync/"
  EMAIL_FRILP_FB_PAGE_URL = "https://www.facebook.com/pages/Frilp/299781060136876"
  EMAIL_FRILP_TWITTER_URL ="https://twitter.com/frilp_me"
  
  #Request - Expiry options
  REQUEST_EXPIRY_OPTION_TWO_HOURS = 1
  REQUEST_EXPIRY_OPTION_ONE_DAY = 2
  REQUEST_EXPIRY_OPTION_WEEK = 3
  REQUEST_EXPIRY_OPTION_TWO_WEEK = 4
  
  REQUEST_EXPIRY_OPTION_TWO_HOURS_VALUE = "two hours"
  REQUEST_EXPIRY_OPTION_ONE_DAY_VALUE = "a day"
  REQUEST_EXPIRY_OPTION_WEEK_VALUE = "a week"
  REQUEST_EXPIRY_OPTION_TWO_WEEK_VALUE = "two weeks"
  
  # for location calculation
  EARTH_RADIUS = 6371 # km

  # member
  MEMBER_SEARCH_TYPE_ALL = 0
  MEMBER_SEARCH_TYPE_MYCONTACTS = 1
  MEMBER_SEARCH_TYPE_MYCOMMUNITIES = 2

end
