module V1
  module Entities
    class LoginUser < V1::Entities::User
      expose :authentication_token, documentation: { type: 'String', desc: 'Token' }
    end
  end
end
