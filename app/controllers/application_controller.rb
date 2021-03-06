class ApplicationController < ActionController::API

  after_action :cors_set_access_control_headers

def cors_set_access_control_headers
  headers['Access-Control-Allow-Origin']      = '*'
  headers['Access-Control-Allow-Methods']     = 'POST, GET, OPTIONS'
  headers['Access-Control-Max-Age']           = '1728000'
  headers['Access-Control-Allow-Credentials'] = 'true'
end
end
