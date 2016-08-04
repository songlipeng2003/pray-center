module V1
  module Entities
    class Result < Grape::Entity
      expose :result, documentation: { type: 'Boolean', desc: '结果，true为正确，false为错误' }
    end
  end
end
