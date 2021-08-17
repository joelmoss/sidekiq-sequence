# frozen_string_literal: true

require 'test_helper'

class FirstSequence < Sidekiq::Sequence::Base; end

class SecondSequence < Sidekiq::Sequence::Base
  class Step1; end

  class Step2; end
  step Step1
  step Step2
end

class ThirdSequence < Sidekiq::Sequence::Base
  class Step1; end
  step Step1
end

class Sidekiq::Sequence::BaseTest < Minitest::Test
  def test_steps
    assert_nil Sidekiq::Sequence::Base.steps
    assert_nil FirstSequence.steps
    assert_equal ['SecondSequence::Step1', 'SecondSequence::Step2'],
                 SecondSequence.steps
    assert_equal ['ThirdSequence::Step1'], ThirdSequence.steps
    assert_nil Sidekiq::Sequence::Base.steps
  end
end
