FactoryGirl.define do
  factory :project do
    points 3
    title 'Envie Proposta'
  end

  factory :story do
    importance 1
    points 3
    project { FactoryGirl.build(:project) }
    title 'Create user'
  end
end
