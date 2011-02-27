require 'spec_helper'

module OndasInCloud
  module Infra
    describe App do
      it 'deveria ter um metodo call, que responda de acordo com os parametros do rack' do
        env = mock(:environment)
        App.new.call(env)
      end
    end
  end
end
