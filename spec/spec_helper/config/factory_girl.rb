include FactoryGirl::Syntax::Methods

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

  let(:user_stubbed) { build_stubbed(:user) }
  let(:user_a_stubbed) { build_stubbed(:user) }
  let(:user_b_stubbed) { build_stubbed(:user) }
  let(:banned_stubbed) { build_stubbed(:user, :banned) }
  let(:administrator_stubbed) { build_stubbed(:user, :administrator) }
  let(:moderator_stubbed) { build_stubbed(:user, :moderator) }
  let(:superuser_stubbed) { build_stubbed(:user, :superuser) }
  let(:poem_stubbed) { build_stubbed(:poem) }
  let(:genre_stubbed) { build_stubbed(:genre) }
  let(:commentary_stubbed) { build_stubbed(:commentary) }
  let(:poem_genre_stubbed) { build_stubbed(:poem_genre) }
  let(:rival_victim_stubbed) { build_stubbed(:rival_victim) }
  let(:fan_idol_stubbed) { build_stubbed(:fan_idol) }
  let(:upvoter_stubbed) { build_stubbed(:poem_voter, :up) }
  let(:downvoter_stubbed) { build_stubbed(:poem_voter, :down) }
end

RSpec.configure do |config|
  config.include FactoryContext
end