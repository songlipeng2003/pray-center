module V1
  module Entities
    class Result < Grape::Entity
      expose :result, documentation: { type: 'Boolean', desc: '结果，0为正确，1为错误' }
    end
  end
end
