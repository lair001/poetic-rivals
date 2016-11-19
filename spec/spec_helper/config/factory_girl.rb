include FactoryGirl::Syntax::Methods

module FactoryContext
  extend RSpec::SharedContext
  let(:user) { build(:user) }
  let(:user_a) { build(:user) }
  let(:user_b) { build(:user) }
  let(:poem) { build(:poem) }
  let(:genre) { build(:genre) }
  let(:commentary) { build(:commentary) }
  let(:poem_genre) { build(:poem_genre) }
  let(:rival_victim) { build(:rival_victim) }
  let(:fan_idol) { build(:fan_idol) }

  let(:user_stubbed) { build_stubbed(:user) }
  let(:user_a_stubbed) { build_stubbed(:user) }
  let(:user_b_stubbed) { build_stubbed(:user) }
  let(:poem_stubbed) { build_stubbed(:poem) }
  let(:genre_stubbed) { build_stubbed(:genre) }
  let(:commentary_stubbed) { build_stubbed(:commentary) }
  let(:poem_genre_stubbed) { build_stubbed(:poem_genre) }
  let(:rival_victim_stubbed) { build_stubbed(:rival_victim) }
  let(:fan_idol_stubbed) { build_stubbed(:fan_idol) }
end

RSpec.configure do |config|
  config.include FactoryContext
end