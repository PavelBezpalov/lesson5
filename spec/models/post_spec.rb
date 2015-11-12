require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:user) }
  it do
    should validate_length_of(:title).
        is_at_least(5).is_at_most(140)
  end
  it { should validate_length_of(:body).is_at_least(140) }
end
