# frozen_string_literal: true

require 'test_helper'

class Sidekiq::SequenceTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sidekiq::Sequence::VERSION
  end
end
