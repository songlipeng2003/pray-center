module V1
  module Entities
    class Error < Grape::Entity
      expose :error, documentation: { type: String, desc: '错误' }
    end
  end
end
