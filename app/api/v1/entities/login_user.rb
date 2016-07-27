module V1
  module Entities
    class LoginUser < User
      expose :authentication_token
    end
  end
end
