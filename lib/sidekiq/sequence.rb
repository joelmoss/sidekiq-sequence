# frozen_string_literal: true

require 'rails'
require 'active_support/dependencies'
require 'sidekiq/sequence/version'
require 'sidekiq/sequence/engine'

module Sidekiq
  module Sequence
    autoload :Base, 'sidekiq/sequence/base'
    autoload :Worker, 'sequence/worker'
  end
end
