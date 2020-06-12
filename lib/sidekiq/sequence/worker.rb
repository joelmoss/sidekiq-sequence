# frozen_string_literal: true

require 'sidekiq/sequence/perform'

module Sidekiq
  module Sequence
    module Worker
      extend ActiveSupport::Concern

      included do
        include Sidekiq::Worker
        prepend Perform
      end
    end
  end
end
