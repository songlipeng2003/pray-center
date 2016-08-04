module V1
  module Entities
    class Data < Grape::Entity
      expose :data, documentation: { type: 'String', desc: '结果' }
    end
  end
end
