# frozen_string_literal: true

module Sidekiq
  module Sequence
    class Engine < ::Rails::Engine
      isolate_namespace Sidekiq::Sequence
    end
  end
end
