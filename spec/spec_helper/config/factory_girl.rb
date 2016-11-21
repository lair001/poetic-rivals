include FactoryGirl::Syntax::Methods

module FactoryGirlSpecHelper
  module Generators

    def random_poem_voter_value_trait
      [:up, :down][rand(0..1)]
    end

    def random_poem_voter_value
      [-1, 1][rand(0..1)]
    end

  end
end

include FactoryGirlSpecHelper::Generators

module FactoryContext
  extend RSpec::SharedContext
  let(:user) { build(:user) }
  let(:user_a) { build(:user) }
  let(:user_b) { build(:user) }
  let(:banned) { build(:user, :banned) }
  let(:administrator) { build(:user, :administrator) }
  let(:moderator) { build(:user, :moderator) }
  let(:superuser) { build(:user, :superuser) }
  let(:poem) { build(:poem) }
  let(:genre) { build(:genre) }
  let(:commentary) { build(:commentary) }
  let(:poem_genre) { build(:poem_genre) }
  let(:rival_victim) { build(:rival_victim) }
  let(:fan_idol) { build(:fan_idol) }
  let(:upvoter) { build(:poem_voter, :up) }
  let(:downvoter) { build(:poem_voter, :down) }

  let(:stubbed_user) { build_stubbed(:user) }
  let(:stubbed_user_a) { build_stubbed(:user) }
  let(:stubbed_user_b) { build_stubbed(:user) }
  let(:stubbed_banned) { build_stubbed(:user, :banned) }
  let(:stubbed_administrator) { build_stubbed(:user, :administrator) }
  let(:stubbed_moderator) { build_stubbed(:user, :moderator) }
  let(:stubbed_superuser) { build_stubbed(:user, :superuser) }
  let(:stubbed_poem) { build_stubbed(:poem) }
  let(:stubbed_genre) { build_stubbed(:genre) }
  let(:stubbed_commentary) { build_stubbed(:commentary) }
  let(:stubbed_poem_genre) { build_stubbed(:poem_genre) }
  let(:stubbed_rival_victim) { build_stubbed(:rival_victim) }
  let(:stubbed_fan_idol) { build_stubbed(:fan_idol) }
  let(:stubbed_upvoter) { build_stubbed(:poem_voter, :up) }
  let(:stubbed_downvoter) { build_stubbed(:poem_voter, :down) }
end

RSpec.configure do |config|
  config.include FactoryContext
end